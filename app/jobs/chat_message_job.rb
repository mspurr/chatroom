class ChatMessageJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatroom_#{message.chatroom_id}", message: message.to_json, user: message.user.to_json
  end
end
