class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required"
    end
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.find(params[:user_friendship][:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
      @user_friendship.save
      flash[:success] = "You are now friends with #{@friend.username}"
      redirect_to user_path(@friend.username)
    else
      flash[:error] = "Friend required"
      redirect_to root_path
    end
  end
end
