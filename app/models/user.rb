class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, format: { with: Devise.email_regexp }
  has_many :activities
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
