require 'net/http'
require 'json'

class WdiAPI
  @@host = "https://calm-beach-9546.herokuapp.com"

  def self.get_info
    uri = URI(@@host)
    uri.path = '/api/v1/info'
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.get_talks
    uri = URI(@@host)
    uri.path = '/api/v1/talks'
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
