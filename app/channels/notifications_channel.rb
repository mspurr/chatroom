# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications:#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_notification(data)

  end

  def get_notifications
    num_notifications = Notification.where(user: current_user.id, read: false).count
    NotificationRelayJob.perform_later(num_notifications)
  end
end
