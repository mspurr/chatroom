$ ->
  if currentChatroom = $("meta[name='chatroom_params']").data("chatroom")
    App.chatrooms = App.cable.subscriptions.create { channel: "ChatroomsChannel", chatrooms_id: currentChatroom.id },
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log "Chatroom connected: #{currentChatroom.title}"
        #@perform 'get_user_count'

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log "Chatroom disconnected: #{currentChatroom.title}"

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        chatElement = $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']")
        chatElement.append(data.chat_message)
        chatElement.prop({ scrollTop: $(".chat_message_area").prop("scrollHeight") })

        if data.users
          null

        # handle hash tag
        if data.hash_tag?.tags.length > 0
          console.log tag for tag in data.hash_tag.tags

      send_message: (chatroom_id, message) ->
        @perform "send_message", {chatroom_id: chatroom_id, body: message}

      get_users: ->
        @perform "get_users"

  $('#chat_message_body').bind 'input propertychange', ->
    # console.log "Pressed key: #{$(this).val()}"
    null
