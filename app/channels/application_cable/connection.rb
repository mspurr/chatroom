module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    def connect
      self.uuid = SecureRandom.uuid
      # logger.add_tags 'ActionCable', current_user.name
    end

    # protected
    #   def find_verified_user
    #     if verified_user = User.find_by(id: cookies.signed[:user_id])
    #       verified_user
    #     else
    #       reject_unauthorized_connection
    #     end
    #   end
  end
end
