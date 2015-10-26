class Chatroom < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :broadcasts

  validates :game, presence: true
  validates :title, presence: true
  validates :description, presence: true

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
