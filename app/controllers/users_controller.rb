class UsersController < ApplicationController
  before_action :find_user, only: [:show, :profile]
  before_action :authenticate_user!
  before_action :get_counts, only: [:index, :show]
  impressionist :actions=>[:show]


  def index
    case params[:people] when "friends"
      @users = current_user.active_friends
    when "requests"
      @users = current_user.pending_friend_requests_from.map(&:user)
    when "pending"
      @users = current_user.pending_friend_requests_to.map(&:friend)
    else
      @users = current_user.active_friends
    end
  end

  def show
    impressionist(@user)
    @friends = @user.active_friends
  end

  def profile
  end

  private

  def find_user
    @user = User.find_by_username(params[:id])
    #@user = User.where("LOWER(username) = ?", params[:id].downcase)
  end

  def get_counts
    @friend_count = current_user.active_friends.size
    @pending_count = current_user.pending_friend_requests_to.map(&:friend).size
  end


end
