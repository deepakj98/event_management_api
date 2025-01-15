class BookingsController < ApplicationController
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token

  def index
    if current_user
      if current_user.admin?
        bookings = Booking.all
      else
        bookings = current_user.bookings
      end
      render json: bookings
    else
      render json: {error: "kindly login"}
    end
  end

  def create
    event = Event.find_by(id: params[:event_id])
    if event
      booking = event.bookings.new(user: current_user, status: 'pending')
      if booking.save
        render json: booking, status: :created
      else
        render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    else
        render json: { errors: "event not found" }
    end
  end

  def approve
    booking = Booking.find_by(id: params[:id])
    if booking
      if current_user.admin? && booking.update(status: 'approved')
        render json: booking
      else
        render json: { error: 'Unauthorized or Invalid booking' }, status: :unauthorized
      end
    else
        render json: { error: 'not found' }
    end
  end

  def reject
    booking = Booking.find_by(id: params[:id])
    if booking
      if current_user.admin? && booking.update(status: 'rejected')
        render json: booking
      else
        render json: { error: 'Unauthorized or Invalid booking' }, status: :unauthorized
      end
    else
        render json: { error: 'not found' }
    end
  end

  def destroy
    booking = Booking.find_by(params[:id])
    if booking
      if booking.user == current_user || current_user.admin?
        booking.destroy
        head :no_content
      else
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    else
      render json: {error: 'booking not present for this id'}
    end
  end
end
