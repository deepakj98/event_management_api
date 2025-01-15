class Event < ApplicationRecord
  belongs_to :venue
  has_many :bookings

  validates :price, numericality: { greater_than_or_equal_to: 50, message: "must be at least 50" }
end
