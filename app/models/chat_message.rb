class ChatMessage < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :message, :chatroom_id

  after_create_commit { ChatMessageJob.perform_later(self) }
end
