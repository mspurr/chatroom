class User < ActiveRecord::Base
	validates_uniqueness_of :username
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    # Virtual attribute for authenticating by either username or email
  	# This is in addition to a real persisted field like 'username'
  	attr_accessor :login

	has_many :chatrooms
	has_many :broadcasts


	def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
    end

end

