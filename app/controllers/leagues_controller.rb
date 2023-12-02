class LeaguesController < ApplicationController
  def index
    @leagues = JSON.parse(REDIS.get('leagues'))['response']
  end
end
