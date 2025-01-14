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
    venue = Venue.find(params[:id])
    if venue.update(venue_params)
      render json: venue
    else
      render json: { errors: venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    venue = Venue.find(params[:id])
    venue.destroy
    head :no_content
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :location, :capacity)
  end
end


# Action Index
# ENDPOINT /venues

# Response 
# [
#     {
#         "id": 1,
#         "name": "Milan",
#         "location": "New Delhi",
#         "capacity": 100,
#         "created_at": "2025-01-14T15:24:28.772Z",
#         "updated_at": "2025-01-14T15:24:28.772Z"
#     }
# ]



# Action Create
# ENDPOINT /venues

# PAYLOAD

# {
#     "venue": {
#         "name": "Milan",
#         "location": "New Delhi",
#         "capacity": 100
#     }
# }



# RESPONSE

# {
#     "id": 2,
#     "name": "Milan",
#     "location": "New Delhi",
#     "capacity": 100,
#     "created_at": "2025-01-14T15:28:22.864Z",
#     "updated_at": "2025-01-14T15:28:22.864Z"
# }


# Action Update
# ENDPOINT /venues/:id

# payload:

# {
#     "venue": {
#         "name": "Grand Milan",
#         "location": "New Delhi",
#         "capacity": 200
#     }
# }


# response:
# {
#     "name": "Grand Milan",
#     "location": "New Delhi",
#     "capacity": 200,
#     "id": 2,
#     "created_at": "2025-01-14T15:28:22.864Z",
#     "updated_at": "2025-01-14T15:28:22.864Z"
# }
