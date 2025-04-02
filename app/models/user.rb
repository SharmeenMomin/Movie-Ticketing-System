class User < ApplicationRecord
  has_secure_password
  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :name, presence: true, uniqueness: false
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :credit_card, presence: true

  # Associations
  has_many :bookings
  has_many :tickets, dependent: :destroy

    # Prevents storing real credit card numbers
    # def masked_credit_card
    #   "**** **** **** " + credit_card[-4..-1]
    # end

end
