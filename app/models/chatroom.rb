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

end
