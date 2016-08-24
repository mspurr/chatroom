class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    chat_message = @chatroom.chat_messages.new(chat_message_params)
    chat_message.user = current_user
    chat_message.save
    MessageRelayJob.perform_later(chat_message)
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    def chat_message_params
      params.require(:chat_message).permit(:body)
    end
end
