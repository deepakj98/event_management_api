class EventsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    venue = Venue.find_by(id: params[:venue_id])
    if venue
      events = venue.events
      render json: events
    else
      render json: {errors: "event not present"}
    end
  end

  def create
    venue = Venue.find_by(id: params[:venue_id])
    if venue.present?
      event = venue.events.new(event_params)
      if event.save
        render json: event, status: :created
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {errors: "venue not present for this venue_id"}
    end
  end

  def update
    event = Event.find_by(id: params[:id])
    if event.present?
      if event.update(event_params)
        render json: event
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {errors: "event not present for this id"}
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])
    if event
      event.destroy
      render json: { success: "deleted successfully" }
    else
      render json: { error: "record not found" }
    end
  end

  def search
    if params[:date].blank? && params[:venue_id].blank? && params[:price].blank?
      render json: { errors: "Enter at least one of date, venue_id, or price to search" }, status: :unprocessable_entity
      return
    end

    events = Event.all
    events = events.where("date = ?", params[:date].to_date) if params[:date].present?
    events = events.where("venue_id = ?", params[:venue_id]) if params[:venue_id].present?
    events = events.where("price = ?", params[:price]) if params[:price].present?

    if events.exists?
      render json: events, status: :ok
    else
      render json: { errors: "No events found matching your criteria" }, status: :not_found
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :price)
  end
end
