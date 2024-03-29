class User < ActiveRecord::Base
  has_many :chatrooms
  has_many :broadcasts
  has_many :comments
  has_many :games

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :favorite_chatrooms
  has_many :favorites, through: :favorite_chatrooms, source: :chatroom
  has_many :favorite_games
  has_many :fav_games, through: :favorite_games, source: :game
  has_many :chat_messages
  has_many :notifications


  validates :username, presence: true
  validates :username, uniqueness: true

  validates :about, length: { maximum: 350 }
  validates :links, length: { maximum: 60 }
  validates :team, length:  { maximum: 40 }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ":style/missingavatar.png"
  has_attached_file :cover, styles:  { medium: '1900x1900>' }, default_url: ":style/missingcover.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  acts_as_voter
  searchkick text_start: [:username]

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # For views count
  # is_impressionable

  def request_friendship(user_2)
    self.friendships.create(friend: user_2)
  end

  def pending_friend_requests_from
    self.inverse_friendships.where(state: "pending")
  end

  def pending_friend_requests_to
    self.friendships.where(state: "pending")
  end

  def active_friends
    self.friendships.where(state: "active").map(&:friend) + self.inverse_friendships.where(state: "active").map(&:user)
  end

  def friendship_status(user_2)
    friendship = Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id])
    unless friendship.any?
      return "not_friends"
    else
      if friendship.first.state == "active"
        return "friends"
      else
        if friendship.first.user == self
          return "pending"
        else
          return "requested"
        end
      end
    end
  end

  def friendship_relation(user_2)
    Friendship.where(user_id: [self.id,user_2.id], friend_id: [self.id,user_2.id]).first
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where('lower(username) = :value OR lower(email) = :value', value: login.downcase).first
    else
      where(conditions.to_h).first
    end
  end

  scope :find_random, -> { order("RANDOM()") }

  def self.find_random_user(number)
    find_random.limit(number)
  end

  def follow!(chatroom)
    $redis.multi do
      $redis.sadd(self.redis_key(:following), chatroom.id)
      $redis.sadd(chatroom.redis_key(:followers), self.id)
    end
  end

  def unfollow!(chatroom)
    $redis.multi do
      $redis.srem(self.redis_key(:following), chatroom.id)
      $redis.srem(chatroom.redis_key(:followers), self.id)
    end
  end

  def following
    chatroom_ids = $redis.smembers(self.redis_key(:following))
    Chatroom.where(:id => chatroom_ids)
  end

  def following?(chatroom)
    $redis.sismember(self.redis_key(:following), chatroom.id)
  end

  def following_count
    $redis.scard(self.redis_key(:following))
  end

  def add_active_tag!(tag)
    $redis.sadd(self.redis_key(:tag), tag)
  end
  
  def remove_active_tag!(tag)
    $redis.srem(self.redis_key(:tag), tag)
  end

  def remove_all_tags()
    tags = $redis.smembers(self.redis_key(:tag))
    tags.each do |tag|
      $redis.srem(self.redis_key(:tag), tag)
    end
  end

  def active_tags
    $redis.smembers(self.redis_key(:tag))
  end

  # helper method to generate redis keys
  def redis_key(str)
    "user:#{self.id}:#{str}"
  end
end
