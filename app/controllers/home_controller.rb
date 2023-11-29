class HomeController < ApplicationController
  def index
    redis = Redis.new
    redis.set('a', 1)
    @a = redis.get('a')
  end
end
