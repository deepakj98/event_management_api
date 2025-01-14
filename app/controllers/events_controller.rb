class EventsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    venue = Venue.find(params[:venue_id])
    events = venue.events
    render json: events
  end

  def create
    venue = Venue.find(params[:venue_id])
    event = venue.events.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      render json: event
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    head :no_content
  end

  def search
    events = Event.where("date = ?", params[:date].to_date) if params[:date]
    events = events.where("venue_id = ?", params[:venue_id]) if params[:venue_id]
    events = events.where("price = ?", params[:price]) if params[:price]

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
