class SearchingController < ApplicationController
  before_action :authenticate_user!

  def index
    query = params[:q].presence || "*"
    @chatrooms = Chatroom.search(query, suggest: true)
    @games = Game.search(query)
    @users = User.search(query)
  end

  def autocomplete
    @chatroom = Chatroom.search(params[:term], fields: [{title: :text_start}], limit: 10).map(&:title)
    @game = Game.search(params[:term], fields: [{name: :text_start}], limit: 10).map(&:name)
    @user = User.search(params[:term], fields: [{username: :text_start}], limit: 10).map(&:username)
    @all = @chatroom + @game + @user
    render json: @all
  end

end
