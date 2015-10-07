class BroadcastsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_broadcast, only: [:like, :unlike]
	before_action :set_room, only: [:like, :unlike, :index, :show] 


	def index
		@broadcasts = @room.broadcasts

	end

	def show
		@broadcast = Broadcast.find(params[:id])
		@room = Chatroom.find(params[:chatroom_id])
	end

	def create
		@room = Chatroom.find(params[:chatroom_id])
		@broadcast = Broadcast.create(params[:broadcast].permit(:content, :image))
		@broadcast.user_id = current_user.id
		@broadcast.chatroom_id = @room.id

		if @broadcast.save
			redirect_to chatroom_path(@room)
		else
			redirect_to chatroom_path(@room), notice: 'Please try again.'
		end
	end

	def like
		@broadcast.liked_by current_user
		redirect_to chatroom_path(@room)
	end

	def unlike
		@broadcast.unliked_by current_user
		redirect_to chatroom_path(@room)
	end

	private

	def set_broadcast
		@broadcast = Broadcast.find(params[:id])
	end

	def set_room
		@room = Chatroom.find(params[:chatroom_id])
	end
end
