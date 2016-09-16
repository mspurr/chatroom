dispatcher = App.dispatcher
actionTypes = App.userConstants.actionTypes

App.userStore = do ->
  that = {}
  App.listenerMixin that

  users = []

  dispatcher.register (payload) ->
    switch payload.actionType
      when actionTypes.ADD_USER
        users.push(payload.user)
      when actionTypes.SET_USERS
        users = payload.users
        users.sort(sortUsers)

      when actionTypes.SET_USER_TAGS
        for user in users
          if user.id is payload.user?.id
            user.tags = payload.tags
        users.sort(sortUsers)

      else
        return
    that.notifyListeners()

  sortUsers = (a, b) ->
    return new Date(b.updated_at) - new Date(a.updated_at)

  that.getUsers = -> users
  that.getUserCount = -> users.length
  
  that
