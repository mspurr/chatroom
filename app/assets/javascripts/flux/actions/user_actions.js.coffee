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

  setUserTags = (user, tags) ->
    App.dispatcher.dispatch
      actionType: actionTypes.SET_USER_TAGS
      user: user
      tags: tags

  { 
    add,
    setUsers,
    setUserTags
  }
