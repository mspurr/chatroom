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
        # do something
      else
        return
    that.notifyListeners()

  that.getUsers = ->
    users

  that
