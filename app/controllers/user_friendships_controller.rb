class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_friendship

  def index
    @blocked_friendships, @pending_friendships, @requested_friendships, @accepted_friendships = [], [], [], []
    @user_friendships = current_user.user_friendships.includes(:friend)
    @user_friendships.each do |f|
      @blocked_friendships << f if f.state == 'blocked'
      @pending_friendships << f if f.state == 'pending'
      @requested_friendships << f if f.state == 'requested'
      @accepted_friendships << f if f.state == 'accepted'
    end
  end

  def accept
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.accept!
      flash[:success] = "You are now friends with #{@user_friendship.friend.username}"
    else
      flash[:error] = 'Something went horribly wrong!'
    end
    redirect_to friendships_path
  end

  def block
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.block!
      flash[:success] = "You have blocked #{@user_friendship.friend.username} successfully"
    else
      flash[:error] = 'Something went horribly wrong!'
    end
    redirect_to friendships_path
  end

  def edit
    @user_friendship = current_user.user_friendships.find(params[:id])
    @friend = @user_friendship.friend
  end

  def new
    if params[:friend_id]
      @friend = User.find(params[:friend_id])
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else
      flash[:error] = "Friend required."
      redirect_to root_path
    end
  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:user_friendship] && params[:user_friendship].has_key?(:friend_id)
      @friend = User.find(params[:user_friendship][:friend_id])
      @user_friendship = UserFriendship.request(current_user, @friend)
      respond_to do |format|
        if @user_friendship.new_record?
          format.html do
            flash[:error] = "Something went wrong."
            redirect_to user_friendships_path
          end
          format.json { render json: @user_friendship.to_json, status: :precondition_failed }
        else
          format.html do
            flash[:success] = "Friend request sent."
            redirect_to user_friendships_path
          end
          format.json { render json: @user_friendship.to_json }
        end
      end

    else
      flash[:error] = "Friend required."
      redirect_to root_path
    end
  end

  def destroy
    @user_friendship = current_user.user_friendships.find(params[:id])
    if @user_friendship.destroy
      redirect_to user_friendships_path, success: "You are no longer friends."
    else
      redirect_to user_friendships_path, error: "Something went wrong. Looks like this friendship will last forever!"
    end
  end

  private

  def friendship_association
    case params[:list]
    when nil

    end
  end

  def invalid_friendship
    redirect_to user_friendships_url, error: "Friendship not found"
  end
end

