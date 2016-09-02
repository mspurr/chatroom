App.chatroomActions = do ->
  actionTypes = App.chatroomConstants.actionTypes

  addMessage = (message, user) ->
    App.dispatcher.dispatch
      actionType: actionTypes.ADD_CHAT_MESSAGE
      message: message
      user: user

  setMessages = (messages) ->
    App.dispatcher.dispatch
      actionType: actionTypes.SET_CHAT_MESSAGES
      messages: messages

  {
    addMessage
    setMessages
  }
