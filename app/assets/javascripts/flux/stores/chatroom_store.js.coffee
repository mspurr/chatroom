dispatcher = App.dispatcher
actionTypes = App.chatroomConstants.actionTypes

App.chatroomStore = do ->
  that = {}
  App.listenerMixin that

  messages = []

  dispatcher.register (payload) ->
    switch payload.actionType
      when actionTypes.ADD_CHAT_MESSAGE
        messages.push(payload.message)
      else
        return
    that.notifyListeners()

  that.getMessages = -> messages
  
  that
