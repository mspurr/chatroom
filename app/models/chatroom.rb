class Chatroom < ActiveRecord::Base
	belongs_to :user
	has_many :broadcasts
	belongs_to :game
	
end
