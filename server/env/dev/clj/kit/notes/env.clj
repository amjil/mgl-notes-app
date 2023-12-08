(ns kit.notes.env
  (:require
    [clojure.tools.logging :as log]
    [kit.notes.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init       (fn []
                 (log/info "\n-=[notes starting using the development or test profile]=-"))
   :start      (fn []
                 (log/info "\n-=[notes started successfully using the development or test profile]=-"))
   :stop       (fn []
                 (log/info "\n-=[notes has shut down successfully]=-"))
   :middleware wrap-dev
   :opts       {:profile       :dev
                :persist-data? true}})
