class Broadcast < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }

end
