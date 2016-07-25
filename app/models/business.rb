class Business < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: true
  has_many :questions
  has_many :surveys, as: :responder
  has_many :recommendations,     dependent: :destroy
end
