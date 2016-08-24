class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "chatrooms:#{chat_message.chatroom.id}", {
      chat_message: ChatMessageController.render(chat_message),
      chatroom_id: chat_message.chatroom.id
    }
  end
end
