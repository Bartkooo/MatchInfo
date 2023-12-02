require 'uri'
require 'net/http'
require 'openssl'
require 'redis'

REDIS = Redis.new

def get_data(url)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-host"] = 'v3.football.api-sports.io'
  request["x-rapidapi-key"] = ENV['API_KEY']

  http.request(request)
end

if !REDIS.exists?("leagues")
  url_leagues = URI("https://v3.football.api-sports.io/leagues")
  leagues = get_data(url_leagues).read_body

  REDIS.set('leagues', leagues)
end
