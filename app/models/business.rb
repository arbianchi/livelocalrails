class Business < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: true

  has_many :surveys, as: :responder
end
