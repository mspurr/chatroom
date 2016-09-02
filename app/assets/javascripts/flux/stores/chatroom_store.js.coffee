dispatcher = App.dispatcher
actionTypes = App.chatroomConstants.actionTypes

App.chatroomStore = do ->
  that = {}
  App.listenerMixin that

  messages = []

  dispatcher.register (payload) ->
    switch payload.actionType
      when actionTypes.ADD_CHAT_MESSAGE
        messages.push({
          message: payload.message
          user: payload.user
        })
      when actionTypes.SET_CHAT_MESSAGES
        messages = payload.messages
      else
        return
    that.notifyListeners()

  that.getMessages = -> messages
  
  that
