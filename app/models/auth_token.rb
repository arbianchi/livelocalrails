class AuthToken < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(deleted_at: nil).where(["created_at < ?", Time.now]) }

  validates_uniqueness_of :nonce

  def expire!
    update! deleted_at: Time.now
  end
end
