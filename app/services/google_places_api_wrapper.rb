GOOGLE_API_URL = "https://maps.googleapis.com/maps/api/place/textsearch/json?"


class GooglePlacesAPIWrapper

  include Enumerable

  attr_reader :results

  def initialize raw_results
    @raw_results    = raw_results
    @results        = []
  end

  def self.for ops={}
    location    = ops[:location]
    term        = ops[:term]
    raw_results = GooglePlacesAPI.search({location: location, term: term})
    return self.new(raw_results)
  end

  def process!
    @raw_results.each do |result|
      @results.push(process_result( result ))
    end
  end

private

  def process_result r
    sleep(rand(0..500)/1000.0)
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
