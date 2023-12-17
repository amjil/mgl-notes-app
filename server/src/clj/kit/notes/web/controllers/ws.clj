(ns kit.notes.web.controllers.ws
  (:require
   [ring.util.http-response :as http-response]
   [ring.adapter.undertow.websocket :as undertow-ws]
   [kit.notes.web.utils.token :as token]
   [cheshire.core :as cheshire]
   [clojure.tools.logging :as log]
   [clojure.string :as str]
   [kit.notes.web.utils.db :as db]
   [next.jdbc :as jdbc])
  (:import
   [java.util UUID]))

(declare handle-message
         handle-request
         send-response
         create-record
         update-record
         delete-record
         put-data
         check-data
         check-and-put-data)

          ;;  -----------------
          ;;  |               |
          ;;  -----------------
;; client -> server   ;;sync-data
;; server -> client   ;;sync-data

;; offline client login to server
;; 1 server -> client ;; notify-sync-data
;; 2 client -> server ;; fetch-data
;; 3 client -> sqlite ;; conflict handling  Todo
;; 4 client -> server ;; sync-data

;; ^:private
(def channels (atom {}))

(defn handler [opts {{token :token} :path-params}]
  {:undertow/websocket
   {:on-open
    (fn [{:keys [channel]}]
      (let [user-info (token/decrypt-token (:token-secret opts) token)]
        (swap! channels assoc (:id user-info) channel))
      (println "WS open!"))

    :on-message
    (fn [{:keys [channel data]}]
      (let [user-info (token/decrypt-token (:token-secret opts) token)
            result (cheshire/parse-string data true)]
        (handle-request (assoc opts :channel channel) user-info result)))

    :on-close-message
    (fn [{:keys [_ _]}]
      (let [user-info (token/decrypt-token (:token-secret opts) token)]
        (swap! channels dissoc (:id user-info)))
      (println "WS closeed!"))}})

(defn handle-request [opts userinfo message]
  (when-let [response (handle-message opts userinfo message)]
    (-> response
        (cheshire/generate-string)
        (send-response (:channel opts)))))

(defmulti handle-message
  (fn [_ _ msg]
    (:type msg)))

(defmethod handle-message
  "sync-data"
  [opts userinfo message]
  (log/warn "message = " message)
  (jdbc/with-transaction [tx (jdbc/get-connection (:db-conn opts))]
    (let [{{data :data
            types-of :types_of
            table :table
            sync-id :sync_id
            sync-ids :sync_ids} :data} message
          d (assoc data :user_id (UUID/fromString (:uid userinfo)))]
      (log/warn "d = " d)

      (condp = types-of
        0 (create-record tx table d)
        1 (update-record tx table d)
        2 (delete-record tx table d)
        false)

      ;; Insert waiting_for_sync
      (db/insert! tx :waiting_for_sync
                  {:id (UUID/fromString sync-id) :table_id table :types_of types-of
                   :row_id (or (:id data)
                               (str (:tag_id data)
                                    "|"
                                    (:note_id data)))
                   :user_id (UUID/fromString (:uid userinfo))})

      ;; Insert sync_devices
      (db/insert! tx :sync_devices
                  {:device_id (:id userinfo)
                   :sync_id (UUID/fromString sync-id)})

      ;; send notification to the others
      (when-let [other-devices (db/find-by-keys tx :user_devices
                                                ["user_id = ? and device_id != ?"
                                                 (UUID/fromString (:uid userinfo))
                                                 (:id userinfo)]
                                                {:columns [:device_id]})]
        (map #(when-let [c (get @channels (:device_id %))]
                (send-response message c))
             other-devices))

      {:type "sync-data-result" :data {:sync_id sync-id
                                       :sync_ids sync-ids}})))

(defmethod handle-message
  "sync-data-result"
  [opts userinfo message]
  ;; Insert sync_devices
  (let [{{sync-id :sync_id} :data} message]
    (db/insert! (:db-conn opts)
                :sync_devices
                {:device_id (:id userinfo)
                 :sync_id (UUID/fromString sync-id)})
    {}))

(defmethod handle-message
  "chk-data"
  [opts userinfo _]
  (check-data (:query-fn opts) userinfo))

(defmethod handle-message
  "fetch-data"
  [opts userinfo _]
  (check-and-put-data (:query-fn opts) (:db-conn opts) (:channel opts) userinfo) 
  {})

(defmethod handle-message
  nil
  [_ _ _]
  nil)

(defn send-response
  [data channel]
  (undertow-ws/send data channel))

;;;;;;;;;
(defn create-record [conn table data]
  (let [data (cond-> (assoc data :id (UUID/fromString (:id data)))
               (:folder_id data)
               (update :folder_id #(UUID/fromString %))

               (:parent_id data)
               (update :parent_id #(UUID/fromString %))

               (:tag_id data)
               (update :tag_id #(UUID/fromString %))

               (:note_id data)
               (update :note_id #(UUID/fromString %)))

        result (db/insert! conn table data)]
    (some? result)))

(defn update-record [conn table data]
  (let [result (db/update! conn table
                           ;; No Need to update tag_id note_id ,
                           ;; Because of this both is in tag_notes tables
                           ;; This table No update Operation
                           (cond-> (dissoc data :id)
                             (:folder_id data)
                             (update :folder_id #(UUID/fromString %))

                             (:parent_id data)
                             (update :parent_id #(UUID/fromString %)))
                           {:user_id (:user_id data)
                            :id (UUID/fromString (:id data))})]
    (some? result)))

(defn delete-record [conn table data]
  (let [result (db/delete! conn table (if (nil? (:id data))
                                        {:tag_id (UUID/fromString (:tag_id data))
                                         :note_id (UUID/fromString (:note_id data))}
                                        {:id (UUID/fromString (:id data))}))]
    (some? result)))

(defn put-data [conn data channel]
  (let [result (db/find-one-by-keys
                conn
                (:table_id data)
                (if (nil? (str/index-of (:row_id data) "|"))
                  {:id (UUID/fromString (:row_id data))}
                  (let [x (str/split (:row_id data) #"|")]
                    {:tag_id (UUID/fromString (first x))
                     :note_id (UUID/fromString (last x))})))]
    (try
      (send-response
       (cheshire/generate-string
        {:data {:data (dissoc result :user_id :created_at :updated_at)
                :types_of (:types_of data)
                :table (:table_id data)
                :row (:row_id data)
                :created_at (str (:created_at data))
                :sync_id (:id data)
                :sync_ids (:sync_ids data)}
         :type "sync-data"})
       channel)
      (catch Exception e
        (.printStackTrace e)))))

(defn check-and-put-data
  [query-fn conn channel uinfo]
  (when-let [result (as-> (query-fn :query-server-sync-data {:device_id (:id uinfo)
                                                             :user_id (UUID/fromString (:uid uinfo))}) m
                      (group-by (fn [x] [(get x :table_id) (get x :row_id) (get x :types_of)]) m)
                      (map (fn [[_ v]] (dissoc (assoc (into {} (last v))
                                                      "sync_ids"
                                                      (map #(get % :id) v))
                                               :user_id)) m))]
    (doall
     (map #(put-data conn % channel) result)))) 


(defn check-data [query-fn uinfo]
  (let [result (as-> (query-fn :query-server-sync-count {:device_id (:id uinfo)
                                                         :user_id (UUID/fromString (:uid uinfo))}) m
                 (last m)
                 (:num m))]
    {:type "chk-data-result" :data result}))