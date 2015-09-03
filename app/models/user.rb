class User < ActiveRecord::Base
	validates_uniqueness_of :username
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :chatrooms
end
