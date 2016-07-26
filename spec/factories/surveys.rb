FactoryGirl.define do
  factory :survey do

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
