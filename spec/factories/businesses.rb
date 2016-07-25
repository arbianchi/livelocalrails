FactoryGirl.define do
  factory :business do
    name {      "FAKEBIZ: " + Faker::Company.name }
    address {   Faker::Address.street_address }
    city {      Faker::Address.city }
    zip_code {  Faker::Address.zip_code }
    phone {     Faker::PhoneNumber.phone_number }
    location {  [Faker::Address.latitude,
                 Faker::Address.longitude] }
    yelp_id {   Faker::Code.asin }
  end
end
