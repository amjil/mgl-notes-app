(ns kit.notes.web.controllers.ws
  (:require
   [ring.util.http-response :as http-response]
   [ring.adapter.undertow.websocket :as undertow-ws]
   [kit.notes.web.utils.token :as token]
   [cheshire.core :as cheshire]
   [clojure.tools.logging :as log]
   [kit.notes.web.utils.db :as db]
   [next.jdbc :as jdbc])
  (:import
   [java.util UUID]))

(declare handle-message
         handle-request
         send-response
         create-record
         update-record
         delete-record)

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
  (-> (handle-message opts userinfo message)
      (cheshire/generate-string)
      (send-response (:channel opts))))

(defmulti handle-message
  (fn [_ _ msg]
    (:type msg)))

(defmethod handle-message
  "sync-data"
  [opts userinfo message]
  (jdbc/with-transaction [tx (:db-conn opts)]
    (let [{{data :data
            types-of :types_of
            table :table
            sync-id :sync_id} :data} message
          d (assoc data :user_id (UUID/fromString (:uid userinfo)))]

      (condp = types-of
        0 (create-record tx table d sync-id)
        1 (update-record tx table d sync-id)
        2 (delete-record tx table d sync-id)
        false)

      (db/insert! tx :waiting_for_sync
                  {:id (UUID/fromString sync-id) :table_id table :types_of types-of
                   :row_id (or (get data "id")
                               (str (get data "tag_id")
                                    "|"
                                    (get data "note_id")))
                   :user_id (UUID/fromString (:uid userinfo))})
      
      (db/insert! tx :sync_devices 
                  {:device_id (UUID/fromString (:id userinfo))
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

      {:type "sync-data-ok" :data sync-id})))

(defn send-response 
  [data channel]
  (undertow-ws/send data channel))

;; 
;; (when-let [channel (get @channels uid)]
;;   (wss/send-response
;;    {:type :xxxx}
;;    channel))

(defn create-record [conn table data sync-id]
  (let [data (assoc data :id (UUID/fromString (:id data)))
        result (db/insert! conn table data)]
    (some? result)))

(defn update-record [conn table data sync-id]
  (let [result (db/update! conn table
                           (dissoc data :id)
                           (select-keys data [:id]))]
    (some? result)))

(defn delete-record [conn table data sync-id]
  (let [result (db/delete! conn table (if (nil? (:id data))
                                        data
                                        (select-keys data [:id])))]
    (some? result)))