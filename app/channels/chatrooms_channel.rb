# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    puts "\n\n========================"
    chatroom = Chatroom.find(params[:chatrooms_id])
    current_user.follow!(chatroom)
    chatroom.follow!(current_user)

    stream_from "chatrooms:#{params[:chatrooms_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    chatroom = Chatroom.find(params[:chatrooms_id])
    chatroom.unfollow!(current_user)
    current_user.follow!(chatroom)
    current_user.remove_all_tags
    
    stop_all_streams
  end

  def send_message(data)
    @chatroom = Chatroom.find(data["chatroom_id"])
    chat_message   = @chatroom.chat_messages.create(body: data["body"], user: current_user)
    MessageRelayJob.perform_later(chat_message)
  end

  def get_users
    chatroom = Chatroom.find(params[:chatrooms_id])
    
    ActionCable.server.broadcast "chatrooms:#{chatroom.id}", {
      users: chatroom.followers
    }
  end

end
