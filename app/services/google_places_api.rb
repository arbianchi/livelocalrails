GOOGLE_API_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"


class GooglePlacesAPI

  attr_reader :term, :location, :query, :next_page_token, :raw_results

  def initialize
    @key = ENV['google_places_api_key']
  end

  def text_search ops={}
    @term       = ops[:term]
    @location   = ops[:location]
    @query = ops[:term] + " near " + ops[:location]
    @next_page_token = nil
    @raw_results = []
    @results = []
    get_results
    binding.pry
  end

  def get_results
    loop do
      @raw_results = []
      @raw_results = perform_query
      process!
      @next_page_token = @raw_results["next_page_token"]
      break unless @next_page_token
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

    HTTParty.get GOOGLE_API_URL, query: {**(params)}
  end

  def process!
    @raw_results["results"].each do |r|
      @results.push(process_result( r ))
    end
  end

  private

  def process_result r
    sleep(rand(0..9)/1000.0)
    binding.pry
    result = YelpGemWrapper.find_business(location: r["formatted_address"], term: r["name"])
    binding.pry
    return     {
      address:      r.location.address.join(" "),
      zip_code:     r.location.postal_code,
      phone:        r.phone,
      city:         r.location.city,
      location:     [r.location.coordinate.latitude,
                     r.location.coordinate.longitude],
      image_url:    r.snippet_image_url,
      website_url:  r.url,
      categories:   r.categories.join(","),
      yelp_id:      r.id
    }



  end



end
