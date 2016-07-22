class Survey < ApplicationRecord
  belongs_to :responder, polymorphic: true
end
