GOOGLE_API_TEXT_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
GOOGLE_API_RADAR_SEARCH_URL = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"


class GooglePlacesAPI

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
      binding.pry
      @next_page_token = @response["next_page_token"]
      binding.pry
      break unless @next_page_token
    end
  end

  def perform_query
    binding.pry
    params = {
      "query": @query,
      "key": @key
        }
    #params = {
    #  location: "35.9940, 78.8986",
    #  key: @key,
    #  type: "restaurant"
    #}

    if @next_page_token
      params.merge!({"pagetoken": @next_page_token})
    end

    @response = HTTParty.get GOOGLE_API_TEXT_SEARCH_URL, query: {**(params)}
  end

  # def text_search ops={}
  #   @term       = ops[:term]
  #   @location   = ops[:location]
  #   @query = ops[:term] + " near " + ops[:location]
  #   @next_page_token = nil
  #   @raw_results = []
  #   @results = []
  #   get_results
  #   binding.pry
  # end

  # def get_results
  #   loop do
  #     @raw_results = []
  #     @raw_results = perform_query
  #     process!
  #     @next_page_token = @raw_results["next_page_token"]
  #     break unless @next_page_token
  #   end
  # end

  # def perform_query
  #   params = {
  #     "query": @query,
  #     "key": @key
  #   }
  #   if @next_page_token
  #     params.merge!({"pagetoken": @next_page_token})
  #   end

  #   HTTParty.get GOOGLE_API_URL, query: {**(params)}
  # end

  # def process!
  #   @raw_results["results"].each do |r|
  #     @results.push(process_result( r ))
  #   end
  # end

  # private

  # def process_result r
  #   sleep(rand(0..9)/1000.0)
  #   binding.pry
  #   result = YelpGemWrapper.find_business(location: r["formatted_address"], term: r["name"])
  #   binding.pry
  #   return     {
  #     address:      r.location.address.join(" "),
  #     zip_code:     r.location.postal_code,
  #     phone:        r.phone,
  #     city:         r.location.city,
  #     location:     [r.location.coordinate.latitude,
  #                    r.location.coordinate.longitude],
  #     image_url:    r.snippet_image_url,
  #     website_url:  r.url,
  #     categories:   r.categories.join(","),
  #     yelp_id:      r.id
  #   }
  # end

end
