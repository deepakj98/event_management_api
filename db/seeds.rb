# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear existing data
Booking.destroy_all
Event.destroy_all
Venue.destroy_all
User.destroy_all

# Create Users
puts "Creating users..."
admin = User.create!(email: "admin@example.com", password: "password", role: "admin")
user_one = User.create!(email: "testone@example.com", password: "password", role: "attendee")
user_two = User.create!(email: "testwo@example.com", password: "password", role: "attendee")

# Create Venues
puts "Creating venues..."
venue1 = Venue.create!(name: "City Hall", location: "Noida", capacity: 100)
venue2 = Venue.create!(name: "Community Center", location: "New Delhi", capacity: 200)

# Create Events
puts "Creating events..."
event1 = Event.create!(title: "Music Concert", date: 3.days.from_now, price: 50.00, venue: venue1, description: "lorem ipsum")
event2 = Event.create!(title: "Art Exhibition", date: 5.days.from_now, price: 30.00, venue: venue1, description: "lorem ipsum")
event3 = Event.create!(title: "Tech Conference", date: 7.days.from_now, price: 100.00, venue: venue2, description: "lorem ipsum")

# Create Bookings
puts "Creating bookings..."
Booking.create!(user: user_one, event: event1, status: "pending")
Booking.create!(user: user_two, event: event2, status: "approved")
Booking.create!(user: user_one, event: event3, status: "rejected")

puts "Seeding complete!"
