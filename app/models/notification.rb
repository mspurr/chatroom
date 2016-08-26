class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :sender, class_name: "User"
  
  # def after_save(notification)
  #   ActionCable.server.broadcast "notifications:#{user.id}", {
  #     notification: notification,
  #     chatroom_id: Chatroom.find(chat_message.chatroom.id)
  #   } 
  # end
end
