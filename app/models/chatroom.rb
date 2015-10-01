class Chatroom < ActiveRecord::Base
	belongs_to :user
	has_many :broadcasts
	belongs_to :game

	def game_name
		game.try(:name)
	end

	def game_name=(name)
		self.game = Game.find_by_name(name) if name.present?
		
	end
	
end
