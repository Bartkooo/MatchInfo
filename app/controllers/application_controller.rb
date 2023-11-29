class ApplicationController < ActionController::Base
  REDIS = Redis.new()
end
