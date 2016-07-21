FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password "password"
    zip_code { Faker::Address.zip_code }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.user_name }
  end
end
