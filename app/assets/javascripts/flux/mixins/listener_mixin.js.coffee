App.listenerMixin = (that) ->
  listeners = []

  addChangeListener = (listener) ->
    listeners.push(listener)

  removeChangeListener = (listenerToRemove) ->
    listeners = (listener for listener in listeners when listener isnt listenerToRemove)

  notifyListeners = ->
    do (listeners) ->
      listener() for listener in listeners

  that.addChangeListener = addChangeListener
  that.removeChangeListener = removeChangeListener
  that.notifyListeners = notifyListeners

  that