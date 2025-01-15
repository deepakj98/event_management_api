class VenuesController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    venues = Venue.all
    render json: venues
  end

  def create
    venue = Venue.new(venue_params)
    if venue.save
      render json: venue, status: :created
    else
      render json: { errors: venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    venue = Venue.find_by(id: params[:id])
    if venue.present?
      if venue.update(venue_params)
        render json: venue
      else
        render json: { errors: venue.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {errors: "venue not found"}
    end
  end

  def destroy
    venue = Venue.find_by(id: params[:id])
    if venue
      venue.destroy
      render json: {success: "deleted record"}
    else
      render json: {else: "not found"}
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :location, :capacity)
  end
end

