class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
      session[:user_id] = user.id
      render json: { token: token }, status: :created
    else
      render json: { error: 'invalid credentials' }, status: :unauthorized
    end
  end
end


# ENDPOINT /users/login POST

# params:
 # email: "jhadeepak746@gmail.com"
 # password: "password"


# response: 
  # {
  #     "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.JlhLkS4gZEsnwuGuAR8upDUVDuf9-DNHj_rRYWg4sqI"
  # }
