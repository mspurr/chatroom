App.userActions = do ->
  actionTypes = App.userConstants.actionTypes

  add = (user) ->
    App.dispatcher.dispatch
      actionType: actionTypes.ADD_USER
      user: user

  setUsers = (users) ->
    App.dispatcher.dispatch
      actionType: actionTypes.SET_USERS
      users: users

  { 
    add,
    setUsers
  }
