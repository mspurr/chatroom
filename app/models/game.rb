class Game < ActiveRecord::Base
  has_many :chatrooms
  validates :name, presence: true

  has_attached_file :thumb, styles: { medium: '700x300>' }
  has_attached_file :cover, styles: { medium: '430x510>' }

  validates_attachment_content_type :thumb, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

end
