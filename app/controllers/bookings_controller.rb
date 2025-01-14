class BookingsController < ApplicationController
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token

  def index
    if current_user.admin?
      bookings = Booking.all
    else
      bookings = current_user.bookings
    end
    render json: bookings
  end

  def create
    event = Event.find(params[:event_id])
    booking = event.bookings.new(user: current_user, status: 'pending')

    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def approve
    booking = Booking.find(params[:id])
    if current_user.admin? && booking.update(status: 'approved')
      render json: booking
    else
      render json: { error: 'Unauthorized or Invalid booking' }, status: :unauthorized
    end
  end

  def reject
    booking = Booking.find(params[:id])
    if current_user.admin? && booking.update(status: 'rejected')
      render json: booking
    else
      render json: { error: 'Unauthorized or Invalid booking' }, status: :unauthorized
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    if booking.user == current_user || current_user.admin?
      booking.destroy
      head :no_content
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
