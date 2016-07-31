LOCU_API_URL = "https://api.locu.com/v2/venue/search"

class LocuAPI

  include Enumerable

  attr_reader :postal_code, :description, :key, :fields, :headers
  attr_accessor :raw_results

  def initialize ops={}
    @key                = ENV['locu_api_key']
    @postal_code        = ops[:postal_code]
    @description        = ops[:description]
    @headers = { 'Content-Type' => 'application/json' }
    @raw_results = []
  end

  def each &block
    @raw_results["venues"].each do |r|
      block.call r
    end
  end

  def self.search ops={}
    o           = self.new(ops)
    body        = {
      "api_key": o.key,
      "fields": ["name", "location", "categories"],
      "venue_queries": [{
        "location": {
          "postal_code": o.postal_code
        }
      }]
    }
    o.raw_results = HTTParty.post(
      LOCU_API_URL,
      headers: o.headers,
      body: body.to_json
    )
    return o
  end

  def self.circular_area_search ops={}
    o           = self.new(ops)
    lat_long    = GeocoderWrapper.for(@postal_code)
    radius      = 5000
    body        = {
      "api_key": o.key,
      "fields": o.fields,
      "venue_queries": [{
        "location": {
          "geo": {
            "$in_lat_lng_radius": [-37.7750, 122.4183, 5000]
          }
        }
      }]
    }
  end


end
