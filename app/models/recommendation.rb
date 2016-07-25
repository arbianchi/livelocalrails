class Recommendation < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :business, scope :user

end
