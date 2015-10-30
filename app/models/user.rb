class User < ActiveRecord::Base
  has_many :chatrooms
  has_many :broadcasts

  has_many :user_friendships, dependent: :destroy
  has_many :friends, -> { where(user_friendships: { state: 'accepted' }).order('name DESC') }, :through => :user_friendships
  has_many :pending_user_friendships, -> { where(state: 'pending') }, class_name: 'UserFriendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_user_friendships, source: :friend
  has_many :requested_user_friendships, -> { where(state: 'requested') }, class_name: 'UserFriendship', foreign_key: 'user_id'
  has_many :requested_friends, through: :requested_user_friendships, source: :friend
  has_many :blocked_user_friendships, -> { where(state: 'blocked') }, class_name: 'UserFriendship', foreign_key: 'user_id'
  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend
  has_many :accepted_user_friendships, -> { where(state: 'accepted') }, class_name: 'UserFriendship', foreign_key: 'user_id'
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend

  validates :username, presence: true
  validates :username, uniqueness: true

  validates :about, length: { maximum: 350 }
  validates :links, length: { maximum: 60 }
  validates :team, length:  { maximum: 40 }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  has_attached_file :cover, styles:  { medium: '1900x1900>' }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  acts_as_voter

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # For views count
  is_impressionable

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
end
