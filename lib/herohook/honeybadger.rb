require 'honeybadger_tasks'

module Herohook
  
  class Honeybadger < Base
    
    def perform
      ::Honeybadger.configure do |honeybadger_config|
        honeybadger_config.api_key = config["api_key"]
      end
      ::HoneybadgerTasks.deploy(
        :rails_env => config["environment"],
        :scm_revision => params[:head],
        :scm_repository => config["repository_url"],
        :local_username => params[:user]
        )
    end
  end
end