class ChatMessage < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  after_create :check_hashtag

  private
  
  def check_hashtag
    if tags = self.body.scan(/#\w+/).flatten
      tags.each do |tag|
        self.user.add_active_tag!(tag)
      end
    end
  end
end
