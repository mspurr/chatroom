class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    ActionCable.server.broadcast "chatrooms:#{chat_message.chatroom.id}", {
      chat_message: ChatMessagesController.render(chat_message),
      chatroom_id: chat_message.chatroom.id,
      user: chat_message.user,
      user_list: ChatroomsController.render('user_list')
    }

    chatroom = Chatroom.find(chat_message.chatroom.id)
    users = chatroom.favorited_by
    users.each do |user|
      notification = Notification.create(sender: User.find(chat_message.user.id), user: user, body: chat_message.body, read: false)

      ActionCable.server.broadcast "notifications:#{user.id}", {
        notification: notification,
        sender: notification.sender,
        user: notification.user,
        chatroom_id: Chatroom.find(chat_message.chatroom.id) 
      }

    end
  end
end
