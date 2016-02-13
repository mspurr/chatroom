# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "games"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def speak(data)
    puts "speaking!"

    puts "Spoken: #{data['content']}"
  end

  def receive(data)
    # ActionCable.server.broadcast "chat_#{params[:room]}", data
  end
end
