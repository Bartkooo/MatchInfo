class LeaguesController < ApplicationController
  before_action :set_leagues, only: [:index, :show]

  def index
  end

  def show
    @league_name = params[:name]
    @id = params[:id]
    url_teams = URI("https://v3.football.api-sports.io/teams?league=#{@id}&season=2023")

    if !REDIS.exists?("teams-#{@id}")
      teams = get_data(url_teams).read_body
      REDIS.set("teams-#{@id}", teams)
    end
    @teams = JSON.parse(REDIS.get("teams-#{@id}"))['response']
  end

  private

  def set_leagues
    @leagues = JSON.parse(REDIS.get('leagues'))['response']
  end

end
