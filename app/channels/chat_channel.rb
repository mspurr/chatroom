# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    # -- TODO:
    # -- stream_from use a string that is unique to a room, use chatroom_id?
    @chatroom = Chatroom.find(params[:room_id])
    puts params[:room_id]
    current_user.join_room(@chatroom)
    stream_from "chatroom_#{@chatroom.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.leave_room(@chatroom)
    ActionCable.server.broadcast "chatroom_#{@chatroom.id}", user_count: @chatroom.user_count
    stop_stream "chatroom_#{@chatroom.id}"
  end

  def speak(data)
    ChatMessage.create(chatroom_id: @chatroom.id, user_id: current_user.id, message: data['content'])
  end

  def get_user_count
    ActionCable.server.broadcast "chatroom_#{@chatroom.id}", user_count: @chatroom.user_count
  end

  def disconnected
    ActionCable.server.broadcast "chatroom_#{@chatroom.id}", user_count: @chatroom.user_count
  end
end
