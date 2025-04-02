class Screen < ApplicationRecord
  has_many :shows, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :capacity, numericality: { greater_than: 0 }
end
