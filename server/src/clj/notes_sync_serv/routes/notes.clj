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
                           (conflict {:code 409
                                     :msg "Data conflict, please merge and resubmit"
                                     :errors "Version conflict"
                                     :server_version (:server_version result)})
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
