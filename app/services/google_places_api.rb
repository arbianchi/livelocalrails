GOOGLE_API_TEXT_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
GOOGLE_API_RADAR_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"


class GooglePlacesAPI

  include Enumerable

  attr_reader :key, :query, :next_page_token, :raw_results, :response

  def self.search ops={}
    self.new ops
  end

  def initialize ops={}
    @key = ENV['google_places_api_key']
    @query = ops[:term] + " near " + ops[:location]
    @next_page_token = nil
    @raw_results = []

    loop do
      perform_query
      @raw_results.push @response["results"]
      @raw_results.flatten!
      @next_page_token = @response["next_page_token"]
      break unless @next_page_token
      sleep 2  # From google: "There is a short delay [until page token] will become valid.
    end
  end

  def each &block
    @raw_results.each do |r|
      block.call r
    end
  end

  def perform_query
    params = {
      "query": @query,
      "key": @key
        }
    if @next_page_token
      params.merge!({"pagetoken": @next_page_token})
    end

    @response = HTTParty.get GOOGLE_API_TEXT_SEARCH_URL, query: {**(params)}
  end
end
