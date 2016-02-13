class Chatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :broadcasts
  has_many :favorite_chatrooms
  has_many :favorited_by, through: :favorite_chatrooms, source: :user

  validates :game, presence: true
  validates :title, presence: true
  validates :description, presence: true

  searchkick text_start: [:title], suggest: [:title]

  def game_name
    game.try :name
  end

  def game_name=(name)
    self.game = Game.find_by(name: name)
  end

  scope :find_random, -> { order("RANDOM()") }

  def self.find_random_room(number)
    find_random.limit(number)
  end

  def add_user(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:users), user.id)
      $redis.sadd(user.redis_key(:joined_room), self.id)
    end
  end

  def remove_user(user)
    $redis.multi do
      $redis.srem(self.redis_key(:users), user.id)
      $redis.srem(user.redis_key(:joined_room), self.id)
    end
  end

  def user_count
    $redis.scard(self.redis_key(:users))
  end

  def users
    user_ids = $redis.smembers(self.redis_key(:users))
    User.where(:id => user_ids)
  end

  def redis_key(str)
    "room:#{self.id}:#{str}"
  end
end
