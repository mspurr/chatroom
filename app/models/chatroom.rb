class Chatroom < ActiveRecord::Base
	belongs_to :user
	has_many :broadcasts
	
end
