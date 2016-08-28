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

  def follow!(user)
    $redis.multi do
      $redis.sadd(self.redis_key(:following), user.id)
      $redis.sadd(user.redis_key(:followers), self.id)
    end
  end

  def unfollow!(user)
    $redis.multi do
      $redis.srem(self.redis_key(:following), user.id)
      $redis.srem(user.redis_key(:followers), self.id)
    end
  end

  # users that self follows
  def followers
    user_ids = $redis.smembers(self.redis_key(:followers))
    User.where(:id => user_ids)
  end

  def follower?(user)
    $redis.sismember(self.redis_key(:followers), user.id)
  end

  def follower_count
    $redis.scard(self.redis_key(:followers))
  end
  
  def add_tag!(tag)
    $redis.sadd(self.redis_key(:tag), tag.id)
  end
  
  def remove_tag!(tag)
    $redis.srem(self.redis_key(:tag), tag.id)
  end

  # helper method to generate redis keys
  def redis_key(str)
    "chatroom:#{self.id}:#{str}"
  end

  

end
