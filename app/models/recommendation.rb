class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :business

  validates_presence_of :business, :user
  validates_uniqueness_of :business, scope: :user

  validate :is_allowed?

  def is_allowed?
    true
  end

end
