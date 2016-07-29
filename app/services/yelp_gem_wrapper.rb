class YelpGemWrapper

  include Enumerable

  attr_reader :results

  def initialize raw_results
    @raw_results =  raw_results
    @results =      []
  end

  def self.for ops={}
    location    = ops[:location]
    term        = ops[:term]
    limit       = 20    # hard limit set by yelp
    raw_results = Yelp.client.search(location, {limit: limit, term: term}).businesses
    return self.new(raw_results)
  end

  def process!
    @raw_results.each do |result|
      @results.push(self.process_result( result ))
    end
  end

  def each &block
    @raw_results.each do |r|
      block.call r
    end
  end

  def self.find_business ops={}
    location    = ops[:location]
    term        = ops[:term]
    Yelp.client.search(location, {limit: 1, term: term}).businesses.first
  end

  private

  def self.process_result r
    begin
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
    rescue => e
      binding.pry
    end
  end

end
