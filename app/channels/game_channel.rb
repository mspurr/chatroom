# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    # -- TODO:
    # -- stream_from use a string that is unique to a room, use chatroom_id?
    @chatroom = Chatroom.find(params[:room_id])
    puts params[:room_id]
    current_user.join_room(@chatroom)
    stream_from "games_#{@chatroom.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.leave_room(@chatroom)
    ActionCable.server.broadcast "games_#{@chatroom.id}", user_count: @chatroom.user_count
    stop_stream "games_#{@chatroom.id}"
  end

  def speak(data)
    ActionCable.server.broadcast "games_#{@chatroom.id}", content: data['content'], user_name: current_user.username, time: Time.now.strftime('%H:%M')
  end

  def get_user_count
    ActionCable.server.broadcast "games_#{@chatroom.id}", user_count: @chatroom.user_count
  end

  def disconnected
    ActionCable.server.broadcast "games_#{@chatroom.id}", user_count: @chatroom.user_count
  end
end
