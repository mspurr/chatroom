App.chatroomActions = do ->
  actionTypes = App.chatroomConstants.actionTypes

  addMessage = (message, user) ->
    App.dispatcher.dispatch
      actionType: actionTypes.ADD_CHAT_MESSAGE
      message: message
      user: user

  {
    addMessage
  }
