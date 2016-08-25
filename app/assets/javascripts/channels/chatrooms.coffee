chatroom_regex = /(\d*).$/g       # picks up the id of a page, eg. http://localhost:3000/chatrooms/1 matches "1"
cable_chatroom_id = document.URL  # gets the url of the page
#cable_chatroom_id = $("[data-behavior='chat-messages']").data("chatroom-id")

App.chatrooms = App.cable.subscriptions.create {channel: "ChatroomsChannel", chatrooms_id: parseFloat(cable_chatroom_id.match(chatroom_regex)[0])},
#App.chatrooms = App.cable.subscriptions.create {channel: "ChatroomsChannel", chatrooms_id: cable_chatroom_id},
  connected: ->
    console.log "Chatroom connected"
    #@perform 'get_user_count'
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']").append(data.chat_message)
    $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']").prop({ scrollTop: $(".chat_message_area").prop("scrollHeight") })

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}


