App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    this.speak()
    console.log("connected")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # $ ->
    #   $('.chat_message_area').append(messageBlock);

    this.speak(data.content)
    console.log("speaking..")

  speak: (content) ->
    console.log("in speak")
    @perform 'speak', content: content
