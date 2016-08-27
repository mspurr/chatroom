class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(num_notifications)
    ActionCable.server.broadcast "notifications:#{current_user.id}", {
      num_notifications: num_notifications 
    }
  end
end
