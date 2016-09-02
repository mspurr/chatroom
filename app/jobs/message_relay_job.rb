class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "chatrooms:#{chat_message.chatroom.id}", {
      chat_message: ChatMessagesController.render(chat_message),
      chatroom_id: chat_message.chatroom.id,
      tags: chat_message.user.active_tags,
      user: chat_message.user
    }
  end
end
