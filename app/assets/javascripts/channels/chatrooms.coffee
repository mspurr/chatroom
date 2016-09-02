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

        if data.action is 'chat_message'
          # DATA CONTENTS
          # chat_message: chat_message,
          # chatroom_id: chat_message.chatroom.id,
          # tags: chat_message.user.active_tags,
          # user: chat_message.user
          App.chatroomActions.addMessage(data.chat_message, data.user
          App.userActions.setUserTags(data.user, data.tags))

        # When a user enters or leaves the chatroom
        if data.action is 'get_users'
          # DATA CONTENTS
          # users: chatroom.followers
          # messages:
          #   user: user
          #   message: message
          App.userActions.setUsers(data.users)
          App.chatroomActions.setMessages(data.messages)

      send_message: (chatroom_id, message) ->
        @perform "send_message", {chatroom_id: chatroom_id, body: message}

      get_users: ->
        @perform "get_users"

  $('#chat_message_body').bind 'input propertychange', ->
    # console.log "Pressed key: #{$(this).val()}"
    null
