class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :business, class_name: "Business", foreign_key: "owner_id"
  has_many :questions
  has_many :surveys, as: :responder
  has_many :recommendations, dependent: :destroy
  has_many :answers, as: :answerer

  validates_presence_of :username, :zip_code, :last_name, :first_name


  has_many :auth_tokens, dependent: :destroy

  def self.with_token nonce
    token = AuthToken.active.find_by nonce: nonce
    token.user if token
  end

  def token_for name
    auth_tokens.active.find_by name: name
  end

  def generate_token_for name
    # TODO: retry until the nonce really is unique (though this should
    # already happy unless you are _extraordinarily_ unlucky)
    auth_tokens.create!(
      name:       name,
      nonce:      SecureRandom.uuid,
      expires_at: 2.weeks.from_now
    )
  end

end
