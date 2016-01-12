class FavoriteChatroom < ActiveRecord::Base
  belongs_to :chatroom
  belongs_to :user

  scope :find_random, -> { order("RANDOM()") }

  def self.find_random_favorite(user, number)
    where(user_id: user).find_random.limit(number)
  end
end
