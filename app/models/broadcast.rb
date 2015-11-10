class Broadcast < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user
  has_many :comments
  acts_as_votable

  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  has_attached_file :image, styles: { medium: "1000x1000>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  scope :featured, -> { order(cached_votes_total: :desc) }

  def self.top_featured
    featured.limit 2
  end
end
