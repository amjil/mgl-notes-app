(ns kit.notes.web.controllers.ws
  (:require
   [ring.util.http-response :as http-response]
   [ring.adapter.undertow.websocket :as undertow-ws]
   [kit.notes.web.utils.token :as token]
   [cheshire.core :as cheshire]
   [clojure.tools.logging :as log]
   [kit.notes.web.utils.db :as db])
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
  (let [{{data :data
          types-of :types_of
          table :table
          sync-id :sync_id} :data} message
        d (assoc data :user_id (UUID/fromString (:uid userinfo)))
        result (condp = types-of
                 0 (create-record (:db-conn opts) table d sync-id)
                 1 (update-record (:db-conn opts) table d sync-id)
                 2 (delete-record (:db-conn opts) table d sync-id)
                 false)]
    ;; Todo notify other devices
    (if (true? result)
      {:type "sync-data-ok" :data sync-id}
      {:type "none"})))

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