chatroom_regex = /(\d*).$/g       # picks up the id of a page, eg. http://localhost:3000/chatrooms/1 matches "1"
cable_chatroom_id = document.URL  # gets the url of the page

App.chatrooms = App.cable.subscriptions.create {"ChatroomsChannel", room_id: parseFloat(cable_chatroom_id.match(chatroom_regex)[0]) },
  connected: ->
    console.log "Chatroom connected"
    @perform 'get_user_count'
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data
