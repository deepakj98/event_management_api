class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token

	def signup
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
			render json: {user: user, token: token}
		else
			render json: { errors: user.errors.full_messages, status: :unprocessable_entity}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation, :role)
	end
end


# ENDPOINT
# POST /users/signup

# payload = 
	# {
    # "user": {
    #     "email": "jhadeepak746@gmail.com",
    #     "password": "password",
    #     "password_confirmation": "password",
    #     "role": 1
    # 	}
	# }

# response = {
#     "user": {
#         "id": 2,
#         "email": "jhadeepak746@gmail.com",
#         "created_at": "2025-01-14T14:59:46.749Z",
#         "updated_at": "2025-01-14T14:59:46.749Z",
#         "role": "attendee"
#     }
# }

