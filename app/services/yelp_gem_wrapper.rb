module YelpGemWrapper
  def self.FindBusiness ops={}
    location    = ops[:location]
    term        = ops[:term]
    Yelp.client.search(location, {limit: 1, term: term}).businesses
  end

  def self.FindBusinesses ops={}
    location    = ops[:location]
    term        = ops[:term]
    limit       = 20    # hard limit set by yelp
    Yelp.client.search(location, {limit: limit, term: term}).businesses
  end
end
