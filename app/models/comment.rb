class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :broadcast
  acts_as_votable

  validates :body, length: { maximum: 500 }, presence: true

end
