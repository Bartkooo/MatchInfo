class TeamsController < ApplicationController
  def show
    @team_id = params[:team_id]
    @team_name = params[:team_name]

    url_team = URI("https://v3.football.api-sports.io/teams?id=#{@team_id}")

    if !REDIS.exists?("team-#{@team_id}")
      team = get_data(url_team).read_body
      REDIS.set("team-#{@team_id}", team)
    end

    @team = JSON.parse(REDIS.get("team-#{@team_id}"))['response']
  end
end
