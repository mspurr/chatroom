class BroadcastsController < ApplicationController
	before_action :authenticate_user!

	def create
		@room = Chatroom.find(params[:chatroom_id])
		@broadcast = Broadcast.create(params[:broadcast].permit(:content))
		@broadcast.user_id = current_user.id
		@broadcast.chatroom_id = @room.id

		if @broadcast.save
			redirect_to chatroom_path(@room)
		else
			redirect_to chatroom_path(@room), notice: 'Please try again.'
		end
	end


end
