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
      else
        return
    that.notifyListeners()

  that.getMessages = -> messages
  
  that
