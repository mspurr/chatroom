$(document).ready ->
  if $("meta[name='current_user']").length > 0 #checks if currently at a chatrooms show page
    #chatroom_regex = /(\d*).$/g       # picks up the id of a page, eg. http://localhost:3000/chatrooms/1 matches "1"
    #cable_chatroom_id = document.URL  # gets the url of the page
    cable_chatroom_id = $("meta[name='current_user']").data("chatroom-id")

    #App.chatrooms = App.cable.subscriptions.create {channel: "ChatroomsChannel", chatrooms_id: parseFloat(cable_chatroom_id.match(chatroom_regex)[0])},
    App.chatrooms = App.cable.subscriptions.create {channel: "ChatroomsChannel", chatrooms_id: cable_chatroom_id},
      connected: ->
        console.log "Chatroom connected"
        #@perform 'get_user_count'
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        message = data.chat_message
        $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']").append(message)
        $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']").prop({ scrollTop: $(".chat_message_area").prop("scrollHeight") })

      send_message: (chatroom_id, message) ->
        @perform "send_message", {chatroom_id: chatroom_id, body: message}
  else
    null

  # $('#chat_message_body').keydown (e) ->
  #   e.preventDefault()
  #   # console.log(e)
  #   console.log "Pressed key: #{e.key}"
  #   $('#chat_message_body').append(e.key)
  #   $('#new_chat_message').submit()

  $('#chat_message_body').bind 'input propertychange', ->
    # e.preventDefault()
    # console.log(e)
    console.log "Pressed key: #{$(this).val()}"
    # $('#chat_message_body').append(e.key)
    # $('#new_chat_message').submit()

