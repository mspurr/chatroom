class ChatroomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_room, only: [:show, :edit, :update, :destroy, :featured_broadcasts]
  before_action :random_room, only: [:show, :index]
  before_action :featured_broadcasts, only: [:show]

  def index
    if params[:game].blank?
      @room = Chatroom.order(created_at: :desc)
    else
      game = Game.where(name: params[:game])
      @room = Chatroom.where(game: game).order(created_at: :desc)
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

  private

  def find_room
    @room = Chatroom.find(params[:id])
  end

  def random_room
    @random = Chatroom.limit(5).shuffle
  end

  def featured_broadcasts
    @feat = @room.broadcasts.order(:cached_votes_total => :desc).limit(2)
  end

  def room_params
    params.require(:chatroom).permit(:title, :description, :game_name)
  end
end
