class Survey < ApplicationRecord
  belongs_to :responder, polymorphic: true

  def questions
    [:hiring, :glutFree, :musicians, :lgbt, :minorityOwned, :livWage, :petFriend, :artsCrafts, :charNonprof, :sustain, :veganPeta]
  end
end
