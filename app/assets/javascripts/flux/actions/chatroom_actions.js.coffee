App.chatroomActions = do ->
  actionTypes = App.chatroomConstants.actionTypes

  addMessage = (message) ->
    App.dispatcher.dispatch
      actionType: actionTypes.ADD_CHAT_MESSAGE
      message: message

  {
    addMessage
  }
