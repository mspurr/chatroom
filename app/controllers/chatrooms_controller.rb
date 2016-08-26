class ChatroomsController < ApplicationController
  before_action :authenticate_user!, except: [:home]
  before_action :find_room, only: [:show, :edit, :update, :destroy, :favorite]
  before_action :get_notifications

  def home
    if params[:tag]
      @broadcast = Broadcast.tagged_with(params[:tag])
    else
      @broadcast = Broadcast.all
    end
  end

  def index

    if params[:sort] == "favorites"
      @fav = true
      @room = current_user.favorites
    elsif params[:sort] == "own"
      @own = true
      @room = Chatroom.where(user_id: current_user.id).order(created_at: :desc)
    elsif params[:game].blank?
      @room = Chatroom.order(created_at: :desc)
    else
      game = Game.where(name: params[:game])
      @room = Chatroom.where(game: game).order(created_at: :desc)
      @game = Game.where(name: params[:game]).first
    end
  end

  def show
    @broadcast = @room.broadcasts.order(created_at: :desc)
  end

  def new
    @room = current_user.chatrooms.build
  end

  def create
    @room = current_user.chatrooms.build(room_params)
    if @room.save
      redirect_to @room
    else
      flash[:alert] = 'Game not found. Please choose a game from the list.'
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to root_path
  end

  # Add and remove favorite chatrooms
  # for current_user
  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @room
      respond_to do |format|
        format.js { render layout: false, content_type: 'text/javascript' }
      end

    elsif type == "unfavorite"
      current_user.favorites.delete(@room)
      respond_to do |format|
        format.js { render layout: false, content_type: 'text/javascript' }
      end

    else
      # Type missing, nothing happens
      redirect_to :back
    end
  end

  private

  def find_room
    @room = Chatroom.find(params[:id])
  end

  def get_notifications
    @notifications = Notification.for(current_user)
  end

  def room_params
    params.require(:chatroom).permit(:title, :description, :game_name)
  end
end
