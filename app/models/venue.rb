class Venue < ApplicationRecord
	has_many :events

	validates :capacity, numericality: { 
		greater_than: 10, 
		less_than_or_equal_to: 500, 
		message: "must be between 10 and 500" 
	}

	validates :name, presence: true
end
