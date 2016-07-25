FactoryGirl.define do
  factory :business do

    name { Faker::Company.name }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    
  end
end
