# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    @chatroom = Chatroom.find(params[:room_id])
    #puts params[:room_id]
    #current_user.join_room(@chatroom)
    stream_from "chatrooms:#{@chatroom.id}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.leave_room(@chatroom)
    ActionCable.server.broadcast "chatrooms:#{@chatroom.id}", user_count: @chatroom.user_count
    stop_stream "chatrooms:#{@chatroom.id}"
  end
end
