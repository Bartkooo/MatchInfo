class TeamsController < ApplicationController
  before_action :set_redis, only: [:show]

  def show
    @team_id = params[:team_id]
    @team_name = params[:team_name]

    url_team = URI("https://v3.football.api-sports.io/teams?id=#{@team_id}")
    url_players = URI("https://v3.football.api-sports.io/players/squads?team=#{@team_id}")

    if !REDIS.exists?("team-#{@team_id}")
      team = get_data(url_team).read_body
      REDIS.set("team-#{@team_id}", team)
    end

    if !REDIS.exists?("players-#{@team_id}")
      players = get_data(url_players).read_body
      REDIS.set("players-#{@team_id}", players)
    end

    @team = JSON.parse(REDIS.get("team-#{@team_id}"))['response']
    @players = JSON.parse(REDIS.get("players-#{@team_id}"))['response']
  end

  private

  def set_redis
    REDIS.select(1)
  end
end
