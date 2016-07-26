class Business < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: true
  has_many :surveys, as: :responder
  has_many :answers, as: :answerer
  has_many :recommendations,     dependent: :destroy

  validate :phone_number_validation
  validates :phone, uniqueness: true
  after_validation :normalize_phone, on:[ :create, :update ]


  def normalize_phone
    self.phone.gsub(/\D/,"")
  end

  def phone_number_validation
    bad_phone = true

    loop do
      # anything other than '.', '-', or number?
      p = self.phone.strip
      p.gsub(/\d|-|\./,"").length > 0 && break

      p.gsub!(/\D/,"")

      # not xxx-xxx-xxxx ?
      phone.length != 10 && break

      # other business with number?
      bad_phone = false
      break
    end

    bad_phone &&
      errors.add(:phone, "must be a valid phone number")

  end

end
