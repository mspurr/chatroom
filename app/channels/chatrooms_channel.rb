# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    #current_user.join_room(@chatroom)
    stream_for @chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @chatroom = Chatroom.find(data["chatroom_id"])
    chat_message   = @chatroom.chat_messages.create(body: data["body"], user: current_user)
    MessageRelayJob.perform_later(chat_message)
  end

end
