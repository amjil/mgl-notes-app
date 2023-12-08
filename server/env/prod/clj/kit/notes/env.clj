(ns kit.notes.env
  (:require [clojure.tools.logging :as log]))

(def defaults
  {:init       (fn []
                 (log/info "\n-=[notes starting]=-"))
   :start      (fn []
                 (log/info "\n-=[notes started successfully]=-"))
   :stop       (fn []
                 (log/info "\n-=[notes has shut down successfully]=-"))
   :middleware (fn [handler _] handler)
   :opts       {:profile :prod}})
