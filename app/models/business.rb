class Business < ApplicationRecord
  belongs_to :user, index: true, foreign_key: :owner_id
  has_many :questions
end
