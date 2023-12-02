class TeamsController < ApplicationController
  def index
    @teams = JSON.parse(REDIS.get('teams'))['response']
  end
end
