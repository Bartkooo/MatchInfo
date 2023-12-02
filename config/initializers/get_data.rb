require 'uri'
require 'net/http'
require 'openssl'
require 'redis'

REDIS = Redis.new

url_leagues = URI("https://v3.football.api-sports.io/leagues")
url_teams = URI("https://v3.football.api-sports.io/teams?country=england")

def get_data(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-host"] = 'v3.football.api-sports.io'
  request["x-rapidapi-key"] = ENV['API_KEY']

  http.request(request)
end

leagues = get_data(url_leagues).read_body
teams = get_data(url_teams).read_body

REDIS.set('leagues', leagues)
REDIS.set('teams', teams)
