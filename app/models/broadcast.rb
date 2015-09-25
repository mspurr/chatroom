class Broadcast < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  has_attached_file :image, styles: { medium: "300x300>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
