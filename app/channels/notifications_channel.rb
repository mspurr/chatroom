# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "notifications_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_stream "notifications_#{current_user.id}"
  end

  def notification_read

  end

  def get_notifications
    ActionCable.server.broadcast "notifications_#{current_user.id}", existing_notifications: Notification.where(user: current_user.id)
  end
end
