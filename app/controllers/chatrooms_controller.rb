class ChatroomsController < ApplicationController
	before_action :find_room, only: [:show, :edit, :update, :destroy]

	def index
		@room = Chatroom.all.order('created_at DESC')
	end

	def show
	end

	def new
		@room = Chatroom.new
	end

	def create
		@room = Chatroom.new(room_params)

		if @room.save
			redirect_to @room
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @room.update(room_params)
			redirect_to @room
		else
			render 'edit'
		end
	end

	def destroy
		@room.destroy
		redirect_to root_path
	end

	private

	def find_room
		@room = Chatroom.find(params[:id])
	end

	def room_params
		params.require(:chatroom).permit(:title, :description)
	end
end
