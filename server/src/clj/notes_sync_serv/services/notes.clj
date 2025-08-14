(ns notes-sync-serv.services.notes
  (:require
   [notes-sync-serv.db.notes :as notes-db]
   [notes-sync-serv.middleware :as middleware]
   [clojure.tools.logging :as log]
   [buddy.core.hash :as hash]
   [buddy.core.codecs :as codecs]))

(defn get-user-id-from-token [token]
  "Extract user ID from token"
  (try
    (let [claims (middleware/dec-data token)]
      (:user claims))
    (catch Exception e
      (log/error e "Failed to extract user_id from token")
      nil)))

(defn calculate-content-hash
  "Calculate hash value for note content"
  [content]
  (-> content
      (hash/sha256)
      (codecs/bytes->hex)))

(defn check-version-conflict [user-id note-id client-version client-base-hash]
  "Check version conflict and base_hash conflict, return conflict info or nil"
  (try
    (let [server-note (notes-db/get-note note-id user-id)]
      (if server-note
        (let [version-conflict (not= (:sync_version server-note) client-version)
              ;; Calculate hash of current note content on server side
              current-content-hash (calculate-content-hash (:content server-note))
              ;; Check if base_hash matches
              hash-conflict (and client-base-hash 
                                (not= client-base-hash current-content-hash))]
          (cond
            ;; Version conflict
            version-conflict
            {:conflict true
             :conflict-type :version-conflict
             :server_version server-note
             :client_version client-version
             :message "Version conflict detected"}
            
            ;; Hash conflict (content conflict)
            hash-conflict
            {:conflict true
             :conflict-type :content-conflict
             :server_version server-note
             :client_base_hash client-base-hash
             :server_content_hash current-content-hash
             :message "Content has been modified since last sync"}
            
            ;; No conflict
            :else nil))
        nil))
    (catch Exception e
      (log/error e "Failed to check version conflict")
      nil)))

(defn sync-note [token note-data]
  "Sync single note, handle conflict detection"
  (try
    (let [user-id (get-user-id-from-token token)
          note-id (:id note-data)
          client-version (:sync_version note-data)
          client-base-hash (:base_hash note-data)]

      (if-not user-id
        {:success false :error "Invalid token"}

        ;; Check version conflict and base_hash conflict
        (if-let [conflict-info (check-version-conflict user-id note-id client-version client-base-hash)]
          conflict-info
          
          ;; No conflict, perform sync
          (let [result (notes-db/upsert-note! (assoc note-data :user_id user-id))]
            (if (:success result)
              {:success true :id note-id :synced true}
              {:success false :error (:error result)})))))
    (catch Exception e
      (log/error e "Failed to sync note")
      {:success false :error (.getMessage e)})))

  (defn get-notes-changes [token query-params]
    "Get notes changes list"
    (try
      (let [user-id (get-user-id-from-token token)
            since (:since query-params)]

        (if-not user-id
          {:success false :error "Invalid token"}

          (let [changes (notes-db/get-notes-since user-id since)]
            {:success true
             :changes changes
             :count (count changes)})))
      (catch Exception e
        (log/error e "Failed to get notes changes")
        {:success false :error (.getMessage e)})))

  (defn get-note [token note-id]
    "Get single note"
    (try
      (let [user-id (get-user-id-from-token token)]

        (if-not user-id
          {:success false :error "Invalid token"}

          (let [note (notes-db/get-note note-id user-id)]
            (if note
              {:success true :note note}
              {:success false :error "Note does not exist"}))))
      (catch Exception e
        (log/error e "Failed to get note")
        {:success false :error (.getMessage e)})))

  (defn batch-sync-notes [token notes-list]
    "Batch sync notes, return conflict list"
    (try
      (let [user-id (get-user-id-from-token token)]

        (if-not user-id
          {:success false :error "Invalid token"}

          (let [results (map #(sync-note token %) notes-list)
                conflicts (filter :conflict results)
                successful (filter #(and (:success %) (:synced %)) results)]

            {:success true
             :synced_count (count successful)
             :conflict_count (count conflicts)
             :conflicts conflicts})))
      (catch Exception e
        (log/error e "Failed to batch sync notes")
        {:success false :error (.getMessage e)})))
