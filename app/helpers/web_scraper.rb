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
  binding.pry

  # open('localbusinesses.txt', 'w') do |f|
  #     f.puts businesses
  # end
