(ns notes-sync-serv.env
  (:require
    [clojure.tools.logging :as log]
    [notes-sync-serv.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (log/info "\n-=[notes-sync-serv started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[notes-sync-serv has shut down successfully]=-"))
   :middleware wrap-dev})
