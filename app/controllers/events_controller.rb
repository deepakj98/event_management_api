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
    events = Event.where("date = ?", params[:date].to_date) if params[:date]
    if events
      events = events.where("venue_id = ?", params[:venue_id]) if params[:venue_id]
    else
      events = Event.where("venue_id = ?", params[:venue_id]) if params[:venue_id]
    end

    if events
      events = events.where("price = ?", params[:price]) if params[:price]
    else
      events = Event.where("price = ?", params[:price]) if params[:price]
    end
    if events
      render json: events
    else
      render json: { errors: "enter date, venue_id, or price to search" }
    end
  end


  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :price)
  end
end
