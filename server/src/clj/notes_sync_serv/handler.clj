(ns notes-sync-serv.handler
  (:require
    [notes-sync-serv.middleware :as middleware]
    [notes-sync-serv.routes.services :refer [service-routes]]
    [reitit.swagger-ui :as swagger-ui]
    [reitit.ring :as ring]
    [ring.middleware.content-type :refer [wrap-content-type]]
    [notes-sync-serv.env :refer [defaults]]
    [mount.core :as mount]))

(mount/defstate init-app
  :start ((or (:init defaults) (fn [])))
  :stop  ((or (:stop defaults) (fn []))))

(defn- async-aware-default-handler
  ([_] nil)
  ([_ respond _] (respond nil)))

(mount/defstate app-routes
  :start
  (ring/ring-handler
    (ring/router
      [["/" {:get
             {:handler (constantly {:status 200 :body "API Server Running"})}}]
       (service-routes)])
    (ring/routes
      (wrap-content-type async-aware-default-handler)
      (ring/create-default-handler))))

(defn app []
  (middleware/wrap-base #'app-routes))
