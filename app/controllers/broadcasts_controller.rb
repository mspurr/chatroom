class BroadcastsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_broadcast, only: [:like, :unlike, :edit, :update, :destroy]
  before_action :set_room, only: [:like, :unlike, :index, :show, :edit, :update, :destroy]


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

    respond_to do |format|
      if @broadcast.save
        format.html { redirect_to @room }
        format.js {}
      else
        format.html { redirect_to chatroom_path(@room), notice: 'Please try again.' }
      end
    end
  end

  def edit
  end

  def update
    if @broadcast.update(broadcast_params)
      redirect_to @room
    else
      render :edit
    end
  end

  def like
    @broadcast.liked_by current_user
    respond_to do |format|
      format.html { redirect_to chatroom_path(@broadcast.chatroom) }
      format.js { render :layout => false }
    end
  end

  def unlike
    @broadcast.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to chatroom_path(@broadcast.chatroom) }
      format.js { render :layout => false }
    end
  end

  def destroy
    @broadcast.destroy
    redirect_to @room
  end

  private

  def set_broadcast
    @broadcast = Broadcast.find(params[:id])
  end

  def set_room
    @room = Chatroom.find(params[:chatroom_id])
  end
  
  def broadcast_params
    params.require(:broadcast).permit(:content, :image)
  end

end
