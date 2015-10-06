class UsersController < ApplicationController
	before_action :find_user, only: [:show, :profile]
	before_action :authenticate_user!

	def show
	end

	def profile
	end

	private

	def find_user
		@user = User.find_by_username(params[:id])
		#@user = User.where("LOWER(username) = ?", params[:id].downcase)
	end


end
