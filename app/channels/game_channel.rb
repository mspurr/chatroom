# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # -- TODO:
    # -- stream_from use a string that is unique to a room, use chatroom_id?
    stream_from "games"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def speak(data)
    puts "Spoken: #{data['content']}"
    ActionCable.server.broadcast "games", content: data['content'], user_name: User.first.username, time: Time.now.strftime('%H:%M')
  end

  def receive(data)

  end
end
