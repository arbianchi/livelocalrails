class GooglePlacesGemWrapper

  include Enumerable

  attr_reader :results

  def initialize raw_results
    @raw_results =  raw_results
    @results =      []
  end

  def self.for ops={}
    @client = GooglePlaces::Client.new(ENV['google_places_api_key'])

    binding.pry
    location        = ops[:
    term            = ops[:term]
    search_string   = term + " near " + location
    raw_results     = @client.spots(*(location), :name => term)
    return self.new(raw_results)
  end

  def process!
    @raw_results.each do |result|
      @results.push(process_result( result ))
    end
  end

  def each &block
    @raw_results.each do |r|
      block.call r
    end
  end

  private

  def process_result r
    binding.pry
    {
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
