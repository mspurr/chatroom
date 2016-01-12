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
    @game = Game.create(params[:game].permit(:name, :thumb, :cover))

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

  def favorite
    @game = Game.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.fav_games << @game
      respond_to do |format|
        format.js { render layout: false, content_type: 'text/javascript' }
      end

    elsif type == "unfavorite"
      current_user.fav_games.delete(@game)
      respond_to do |format|
        format.js { render layout: false, content_type: 'text/javascript' }
      end

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  private

end
