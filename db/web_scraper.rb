require 'httparty'
require 'pry'
require 'csv'
require 'nokogiri'
require 'json'
require 'uri'




categories = [
  "Accounting & Bookkeeping",
  "Automotive",
  "Bars & Clubs",
  "Beauty & Personal Care",
  "Bicycles",
  "Books & Media",
  "Building & Construction",
  "Catering",
  "Children & Toys",
  "Classes & Lessons",
  "Clothing & Shoes",
  "Coffee Shops",
  "Consulting & Business Services",
  "Crafts & Visual Arts",
  "Financial Services",
  "Fitness",
  "Florists",
  "Food & Beverage Distributors",
  "Food Trucks",
  "Graphic Design",
  "Grocery, Specialty Food & Beverage",
  "Health & Wellness",
  "Home & Garden",
  "Home Improvement & Repair",
  "Hotels & Bed & Breakfasts",
  "Jewelry, Accessories, & Gifts",
  "Marketing, Branding, & PR",
  "Medical Services",
  "Merchandise Distributors",
  "Music",
  "Non-Profits & Community Organizations",
  "Office Supplies",
  "Other",
  "Performing Arts",
  "Real Estate",
  "Residential Cleaning",
  "Restaurants",
  "Veterinary & Pets",
  "Web Design"]

  businesses = [] 

  uri_categories = categories.map do |cat|
    URI.encode(cat)
    page = HTTParty.get("http://www.sustainabull.net/directory/?sab_businesstype=#{cat}&sab_search=")
    parsed_page = Nokogiri::HTML(page)
    parsed_page.css("h3 a").map do |e|
      businesses.push(e.text)
    end
  end

  businesses.each do |x|
    b = Yelp.client.search('Durham',term: x )
    address = b.businesses.first.location.address
    zipcode = b.businesses.first.location.postal_code
    phone = b.businesses.first.location.phone
    city = b.businesses.first.location.city
    lat = b.businesses.first.location.coordinate.latitude
    long = b.businesses.first.location.coordinate.longitude
    image_url = b.businesses.first.snippet_image_url
    url = b.businesses.first.url

    Business.create!(name: b, address: address, city: city, zipcode: zipcode, phone: phone, location: "#{lat},#{long}", image_url: image_url, website_url: url) 
  binding.pry
  end

  # open('localbusinesses.txt', 'w') do |f|
  #     f.puts businesses
  # end
