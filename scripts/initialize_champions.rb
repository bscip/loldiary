ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'httparty'

endpoint = 'api/lol/static-data/na/v1.2/champion'

puts "uhh"
resp = HTTParty.get("#{Settings.riot.url}/#{endpoint}?api_key=#{Settings.riot.key}")
if resp.code == 200
  resp_data = JSON.parse(resp.body)
  resp_data['data'].each do |k,champ|
    puts "Getting #{champ['name']}'s full data"
    champ_resp = HTTParty.get("#{Settings.riot.url}/#{endpoint}/#{champ['id'].to_s}?champData=all&api_key=#{Settings.riot.key}")
    if champ_resp.code == 200
      puts "Setting #{champ['name']}"
      #REDIS.set("RIOT_champion_id_#{champ['id'].to_s}", champ_resp.body)
      champ_data = {
        riot_id: champ['id'],
        riot_key: champ['key'],
        name: champ['name'],
        redis_key: "RIOT_champion_id_#{champ['id'].to_s}"
      }
      puts champ_data
      #Champion.create champ_data
    else
      puts "#{Settings.riot.url}/#{endpoint}/#{champ['id'].to_s}?champData=all&api_key=#{Settings.riot.key}"
      puts champ_resp.code
    end
  end
end
