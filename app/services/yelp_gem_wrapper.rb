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

  def self.package_business b
      {
        address:      b.first.location.address.join(" "),
        zip_code:     b.first.location.postal_code,
        phone:        b.first.phone,
        city:         b.first.location.city,
        location:     [b.first.location.coordinate.latitude,
                       b.first.location.coordinate.longitude],
        image_url:    b.first.snippet_image_url,
        website_url:  b.first.url,
        categories:   b.first.categories.join(","),
        yelp_id:      b.first.id
      }
  end
end
