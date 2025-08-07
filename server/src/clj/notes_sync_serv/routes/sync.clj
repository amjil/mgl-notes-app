(ns notes-sync-serv.routes.sync
  (:require
   [notes-sync-serv.db.core :as db]))


(defn query-changes [uid params]
  (db/query-changes {:user_id uid
                     :since (:since params)}))

(defn sync-notes [uid params]
  (let [result (map #(db/sync-note %) params)]
    result))