App.userActions = do ->
  actionTypes = App.userConstants.actionTypes

  add = (user) ->
    App.dispatcher.dispatch
      actionType: actionTypes.ADD_USER
      user: user

  { add }
