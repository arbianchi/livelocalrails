FactoryGirl.define do
  factory :survey do

    factory :business_survey do
      association :responder, factory: :business
      hiring {[true, false].sample}
      glutFree {[true, false].sample}
      musicians {[true, false].sample}
      lgbt {[true, false].sample}
      localFood {[true, false].sample}
      minorityOwned {[true, false].sample}
      livWage {[true, false].sample}
      petFriend {[true, false].sample}
      artsCrafts {[true, false].sample}
      charNonprof {[true, false].sample}
      sustain {[true, false].sample}
      veganPeta {[true, false].sample}
    end

    factory :user_survey do
      association :responder, factory: :user
      hiring {[true, false].sample}
      glutFree {[true, false].sample}
      musicians {[true, false].sample}
      lgbt {[true, false].sample}
      localFood {[true, false].sample}
      minorityOwned {[true, false].sample}
      livWage {[true, false].sample}
      petFriend {[true, false].sample}
      artsCrafts {[true, false].sample}
      charNonprof {[true, false].sample}
      sustain {[true, false].sample}
      veganPeta {[true, false].sample}
    end
  end
end
