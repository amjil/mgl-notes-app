(ns notes-sync-serv.routes.notes
  (:require
   [notes-sync-serv.middleware :as middleware]
   [notes-sync-serv.services.notes :as notes-service]
   [ring.util.http-response :refer [ok conflict]]))

(defn notes-routes []
  ["/notes"
   {:swagger {:tags ["notes"]}
    :middleware [[middleware/wrap-restricted]]}
   
   ["/sync"
    {:post {:summary "Sync notes data"
            :handler (fn [{{body :body} :parameters
                           token :identity}]
                       (let [result (notes-service/sync-note token body)]
                         (if (:conflict result)
                           (let [conflict-type (:conflict-type result)
                                 conflict-msg (case conflict-type
                                               :version-conflict "Version conflict detected"
                                               :content-conflict "Content conflict detected - content has been modified since last sync"
                                               "Data conflict detected")]
                             (conflict {:code 409
                                       :msg conflict-msg
                                       :conflict-type conflict-type
                                       :errors (:message result)
                                       :server_version (:server_version result)
                                       :client_base_hash (:client_base_hash result)
                                       :server_content_hash (:server_content_hash result)}))
                           (ok {:code 200
                                :msg "Sync successful"
                                :data result}))))}}]
   
   ["/changes"
    {:get {:summary "Get notes changes"
           :handler (fn [{{query :query} :parameters
                          token :identity}]
                      (let [data (notes-service/get-notes-changes token query)]
                        (ok {:code 200
                             :msg "Get changes successful"
                             :data data})))}}]
   
   ["/:id"
    {:get {:summary "Get single note"
           :handler (fn [{{{id :id} :path} :parameters
                          token :identity}]
                      (let [data (notes-service/get-note token id)]
                        (ok {:code 200
                             :msg "Get note successful"
                             :data data})))}}]])
