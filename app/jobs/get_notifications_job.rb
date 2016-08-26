class GetNotificationsJob < ApplicationJob
  queue_as :default

  def perform(user)
    notifications = Notification.where(user: user)
    ActionCable.server.broadcast "notifications:#{user}", { existing_notifications: notifications }
  end
end
