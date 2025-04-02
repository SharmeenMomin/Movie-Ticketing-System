class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :status, presence: true, inclusion: { in: ['Booked', 'Cancelled'] }
  validates :user_id, presence: true
  validates :show_id, presence: true
  validate :ensure_seats_are_valid

  # Define a method to generate a unique confirmation number
  before_create :generate_confirmation_number

  private

  def generate_confirmation_number
    self.confirmation_number = SecureRandom.hex(10) unless confirmation_number.present?
  end
  def seats_available
    show = Show.find(self.show_id)
    show.seats_available - show.tickets.count
  end

  def ensure_seats_are_valid
    if seats_available && seats_available < 1
      errors.add(:seat_number, "must be a positive number")
    end
  end

end
