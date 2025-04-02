class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :tickets, dependent: :destroy
  validates :available_seats, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "must be zero or a positive number" }
  validates :ticket_price, numericality: { greater_than_or_equal_to: 0, message: "must be a positive amount" }

  validates :date, :time, :seats_available, :ticket_price, presence: true
  def available?
    seats_available > 0
  end
end
