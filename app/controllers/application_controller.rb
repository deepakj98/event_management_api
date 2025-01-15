class ApplicationController < ActionController::Base

	def current_user
		User.find_by(id: session[:user_id])
	end

	def authenticate_admin
		unless current_user.admin?
			render json: { error: "Access denied. Please log in as admin." }, status: :unauthorized
		end
	end

	def authenticate_user
		unless current_user.present?
			render json: { error: "Access denied. Please log in." }, status: :unauthorized
		end
	end

end
