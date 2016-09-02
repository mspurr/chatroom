$ ->
  if currentChatroom = $("meta[name='chatroom_params']").data("chatroom")
    App.chatrooms = App.cable.subscriptions.create { channel: "ChatroomsChannel", chatrooms_id: currentChatroom.id },
      connected: ->
        # Called when the subscription is ready for use on the server
        console.log "Chatroom connected: #{currentChatroom.title}"
        @perform 'get_users'

      disconnected: ->
        # Called when the subscription has been terminated by the server
        console.log "Chatroom disconnected: #{currentChatroom.title}"

      received: (data) ->
        # Called when there's incoming data on the websocket for this channel
        chatElement = $("[data-behavior='chat-messages'][data-chatroom-id='#{data.chatroom_id}']")
        chatElement.append(data.chat_message)
        chatElement.prop({ scrollTop: $(".chat_message_area").prop("scrollHeight") })

        if data.chat_message
          App.chatroomActions.addMessage(data.chat_message)

        # When a user enters or leaves the chatroom
        if data.users?.length > 0
          App.userActions.setUsers(data.users)
        
        # after chat message is sent
        if data.tags?.length > 0
          App.userActions.setUserTags(data.user, data.tags)

      send_message: (chatroom_id, message) ->
        @perform "send_message", {chatroom_id: chatroom_id, body: message}

      get_users: ->
        @perform "get_users"

  $('#chat_message_body').bind 'input propertychange', ->
    # console.log "Pressed key: #{$(this).val()}"
    null
