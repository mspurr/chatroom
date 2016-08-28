class ChatMessage < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  after_create :check_hashtag

  private
  
  def check_hashtag
    if tags = self.body.scan(/#\w+/).flatten
      ActionCable.server.broadcast "chatrooms:#{self.chatroom_id}", {
        hash_tag: {
          tags: tags,
          user: self.user
        }
      }
    end
  end
end
