class ApplicationController < ActionController::Base

	def current_user
		User.find_by(id: session[:user_id])
	end

	def authenticate_admin
		current_user.admin?
	end

	def authenticate_user
		return unless current_user.present?
	end

end
