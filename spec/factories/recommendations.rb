FactoryGirl.define do
  factory :recommendation do
    business
    user
    value { ["true","false"].sample }
  end
end
