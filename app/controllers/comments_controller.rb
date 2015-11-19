class CommentsController < ApplicationController
  before_action :set_comment, only: [:like, :unlike, :show, :edit, :update, :destroy]

  def create
    @room = Chatroom.find(params[:chatroom_id])
    @broadcast = Broadcast.find(params[:broadcast_id])
    @comment = @broadcast.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @broadcast }
        format.js {}
      else
        format.html { redirect_to chatroom_path(@room), notice: 'Please try again.' }
      end
    end

  end


  def like
    @comment.liked_by current_user
    respond_to do |format|
      format.html { redirect_to chatroom_path(@comment.broadcast.chatroom) }
      format.js { render :layout => false }
    end
  end

  def unlike
    @comment.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to chatroom_path(@comment.broadcast.chatroom) }
      format.js { render :layout => false }
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:broadcast_id, :body, :user_id)
    end
end
