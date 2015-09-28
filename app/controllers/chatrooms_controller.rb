class ChatroomsController < ApplicationController
	before_action :find_room, only: [:show, :edit, :update, :destroy]
	before_action :random_room, only: [:show, :index]
	before_action :authenticate_user!, except: [:index]

	def index
		if params[:game].blank?
			@room = Chatroom.all.order("created_at DESC")
		else
			@game_id = Game.find_by(name: params[:game]).id
			@room = Chatroom.where(game_id: @game_id).order("created_at DESC")
		end
	end

	def show
		@broadcast = @room.broadcasts.all.order('created_at DESC')
	end

	def new
		@room = current_user.chatrooms.build
	end

	def create
		@room = current_user.chatrooms.build(room_params)

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
		@room.dest
		redirect_to root_path
	end

	private

	def find_room
		@room = Chatroom.find(params[:id])
	end

	def random_room
		@random = Chatroom.all.limit(5).shuffle
	end

	def room_params
		params.require(:chatroom).permit(:title, :description, :game_id)
	end
end
