(ns notes-sync-serv.dev-middleware
  (:require
    [notes-sync-serv.config :refer [env]]
    [ring.middleware.reload :refer [wrap-reload]]
    [prone.middleware :refer [wrap-exceptions]]))

(defn wrap-dev [handler]
  (-> handler
      wrap-reload
      ;; disable prone middleware, it can not handle async
      (cond-> (not (env :async?)) (wrap-exceptions {:app-namespaces ['notes-sync-serv]}))))
