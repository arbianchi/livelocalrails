require 'pry'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
businesses = []
File.read(Rails.root.join "db/localbusinesses.txt").each_line do |line|
    businesses << line.chop
end

  businesses.each do |business|
    b = Yelp.client.search('Durham',term: business )
    if b.businesses != []
    address = b.businesses.first.location.address.join(" ")
    zipcode = b.businesses.first.location.postal_code
    phone = b.businesses.first.phone
    city = b.businesses.first.location.city
    lat = b.businesses.first.location.coordinate.latitude
    long = b.businesses.first.location.coordinate.longitude
    image_url = b.businesses.first.snippet_image_url
    url = b.businesses.first.url

    Business.create!(name: business, address: address, city: city, zipcode: zipcode, phone: phone, location: "#{lat},#{long}", image_url: image_url, website_url: url) 
    end
  end
