class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :business, class_name: "Business", foreign_key: "owner_id"
  has_many :questions

  validates_presence_of :username, :zip_code, :last_name, :first_name
end
