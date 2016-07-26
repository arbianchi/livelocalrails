class Answer < ApplicationRecord
  belongs_to :answerer, polymorphic: true
  belongs_to :question
end
