FactoryGirl.define do
  factory :business do

    name { Faker::Company.name }
    zip_code { Faker::Address.zip_code }
    city { Faker::Adress.city }
    user
    
  end
end
