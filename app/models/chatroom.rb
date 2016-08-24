class Chatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :broadcasts
  has_many :favorite_chatrooms
  has_many :favorited_by, through: :favorite_chatrooms, source: :user
  has_many :chat_messages

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

  ## REDIS
  def join_room!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:users), user.id)
      $redis.sadd(user.redis_key(:joined_room), self.id)
    end
  end

  def leave_room!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:users), user.id)
      $redis.srem(user.redis_key(:joined_room), self.id)
    end
  end

  # users that self follows
  def joined_room
    user_ids = $redis.smembers(self.redis_key(:joined_room))
    User.where(:id => user_ids)
  end

  # users that follow self
  def user_list
    user_ids = $redis.smembers(self.redis_key(:users))
    User.where(:id => user_ids)
  end

  # users who follow and are being followed by self
  def in_room
    user_ids = $redis.sinter(self.redis_key(:users), self.redis_key(:joined_room))
    User.where(:id => user_ids)
  end

  # does the user follow self
  def has_chatroom?(user)
    $redis.sismember(self.redis_key(:joined_room), user.id)
  end

  # does self follow user
  def has_user?(user)
    $redis.sismember(self.redis_key(:users), user.id)
  end

  # number of followers
  def joined_room_count
    $redis.scard(self.redis_key(:joined_room))
  end

  # number of users being followed
  def users_count
    $redis.scard(self.redis_key(:users))
  end

  def redis_key(str)
    "room:#{self.id}:#{str}"
  end

end
