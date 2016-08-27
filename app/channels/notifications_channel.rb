# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "notifications:#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def send_notification(data)

  end

  def get_notifications
    puts "========= GET NOTIFICATIONS ============"
    puts current_user.id
    puts Notification.where(user: current_user.id)
    MessageRelayJob.perform_later(current_user.id)
  end
end
