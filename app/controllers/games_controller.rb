class GamesController < ApplicationController
	def index
	end

	def show
		@games = Game.all.order('created_at DESC')
	end

	def new
		@game = Game.new
	end

	def create
		@game = Game.create(params[:game].permit(:name, :thumb))

		if @game.save
			redirect_to chatrooms_path
		else
			redirect_to chatrooms_path
		end
	end

	def destroy
		@game = Game.find(params[:id])
		@game.destroy
		redirect_to root_path
	end

	def edit
	end

	private

end
