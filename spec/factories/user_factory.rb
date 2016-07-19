FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password "password"
    zip_code { Faker::Address.zip_code }
  end
end
