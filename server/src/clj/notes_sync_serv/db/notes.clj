(ns notes-sync-serv.db.notes
  (:require
   [notes-sync-serv.db.core :as db]
   [clojure.tools.logging :as log]))

;; Database operations for notes

(defn create-note!
  "Create new note"
  [{:keys [id user_id title content sync_version]}]
  (try
    (db/create-note! {:id id
                      :user_id user_id
                      :title title
                      :content content
                      :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to create note")
      {:success false :error (.getMessage e)})))

(defn update-note!
  "Update note"
  [{:keys [id user_id title content sync_version]}]
  (try
    (db/update-note! {:id id
                      :user_id user_id
                      :title title
                      :content content
                      :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to update note")
      {:success false :error (.getMessage e)})))

(defn get-note
  "Get single note"
  [id user_id]
  (try
    (db/get-note {:id id :user_id user_id})
    (catch Exception e
      (log/error e "Failed to get note")
      nil)))

(defn get-notes-by-user
  "Get all notes for user"
  [user_id]
  (try
    (db/get-notes-by-user {:user_id user_id})
    (catch Exception e
      (log/error e "Failed to get user notes")
      [])))

(defn get-notes-since
  "Get user notes since specified time"
  [user_id since]
  (try
    (db/get-notes-since {:user_id user_id :since since})
    (catch Exception e
      (log/error e "Failed to get note sync data")
      [])))

(defn upsert-note!
  "Upsert note (insert or update)"
  [{:keys [id user_id content block_ids created_at updated_at sync_version]}]
  (try
    (db/upsert-note! {:id id
                      :user_id user_id
                      :content content
                      :block_ids block_ids
                      :created_at created_at
                      :updated_at updated_at
                      :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to upsert note")
      {:success false :error (.getMessage e)})))

(defn soft-delete-note!
  "Soft delete note"
  [{:keys [id user_id sync_version]}]
  (try
    (db/soft-delete-note! {:id id
                           :user_id user_id
                           :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to delete note")
      {:success false :error (.getMessage e)})))

(defn delete-note!
  "Permanently delete note"
  [id user_id]
  (try
    (db/delete-note! {:id id :user_id user_id})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to permanently delete note")
      {:success false :error (.getMessage e)})))

;; Database operations for tags

(defn create-tag!
  "Create new tag"
  [{:keys [id user_id name color sync_version]}]
  (try
    (db/create-tag! {:id id
                     :user_id user_id
                     :name name
                     :color (or color "#007AFF")
                     :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to create tag")
      {:success false :error (.getMessage e)})))

(defn update-tag!
  "Update tag"
  [{:keys [id user_id name color sync_version]}]
  (try
    (db/update-tag! {:id id
                     :user_id user_id
                     :name name
                     :color color
                     :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to update tag")
      {:success false :error (.getMessage e)})))

(defn get-tag
  "Get single tag"
  [id user_id]
  (try
    (db/get-tag {:id id :user_id user_id})
    (catch Exception e
      (log/error e "Failed to get tag")
      nil)))

(defn get-tags-by-user
  "Get all tags for user"
  [user_id]
  (try
    (db/get-tags-by-user {:user_id user_id})
    (catch Exception e
      (log/error e "Failed to get user tags")
      [])))

(defn get-tags-since
  "Get user tags since specified time"
  [user_id since]
  (try
    (db/get-tags-since {:user_id user_id :since since})
    (catch Exception e
      (log/error e "Failed to get tag sync data")
      [])))

(defn soft-delete-tag!
  "Soft delete tag"
  [{:keys [id user_id sync_version]}]
  (try
    (db/soft-delete-tag! {:id id
                          :user_id user_id
                          :sync_version sync_version})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to delete tag")
      {:success false :error (.getMessage e)})))

(defn delete-tag!
  "Permanently delete tag"
  [id user_id]
  (try
    (db/delete-tag! {:id id :user_id user_id})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to permanently delete tag")
      {:success false :error (.getMessage e)})))

;; Note-tag association operations

(defn add-note-tag!
  "Add tag to note"
  [{:keys [id note_id tag_id]}]
  (try
    (db/add-note-tag! {:id id :note_id note_id :tag_id tag_id})
    {:success true :id id}
    (catch Exception e
      (log/error e "Failed to add note tag")
      {:success false :error (.getMessage e)})))

(defn remove-note-tag!
  "Remove tag from note"
  [note_id tag_id]
  (try
    (db/remove-note-tag! {:note_id note_id :tag_id tag_id})
    {:success true}
    (catch Exception e
      (log/error e "Failed to remove note tag")
      {:success false :error (.getMessage e)})))

(defn get-note-tags
  "Get all tags for note"
  [note_id]
  (try
    (db/get-note-tags {:note_id note_id})
    (catch Exception e
      (log/error e "Failed to get note tags")
      [])))

(defn get-notes-by-tag
  "Get all notes with specific tag"
  [tag_id user_id]
  (try
    (db/get-notes-by-tag {:tag_id tag_id :user_id user_id})
    (catch Exception e
      (log/error e "Failed to get tag notes")
      [])))

;; Sync related operations

(defn get-sync-data
  "Get user sync data"
  [user_id since]
  (try
    (db/get-sync-data {:user_id user_id :since since})
    (catch Exception e
      (log/error e "Failed to get sync data")
      []))) 