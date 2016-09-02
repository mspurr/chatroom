App.dispatcher = do ->
  prefix = 'ID_'

  isHandled = {}
  isPending = {}
  callbacks = {}

  actionToken = 0
  isDispatching = false
  lastIDSuffix = 0
  pendingPayload = null

  register = (callback) ->
    id = prefix + ++lastIDSuffix
    callbacks[id] = callback
    id

  startDispatching = (payload) ->
    isPending = {}
    isHandled = {}
    pendingPayload = payload
    isDispatching = true
    actionToken++

  stopDispatching = ->
    pendingPayload = null
    isDispatching = false

  dispatch = (payload) ->
    if isDispatching
      throw new Error("Dispatch.dispatch(...): Cannot dispatch in the middle of a dispatch.")

    unless payload.actionType?
      throw new Error('Dispatcher received message with no action type! (Did you forget to declare a constant?)')

    startDispatching(payload)

    try
      invokeCallback(id) for id of callbacks when not isPending[id]
    finally
      stopDispatching()

  invokeCallback = (id) ->
    isPending[id] = true
    callbacks[id](pendingPayload)
    isHandled[id] = true

  waitFor = (ids) ->
    for id in ids
      if isPending[id]
        unless isHandled[id]
          throw new Error("Dispatcher.waitFor(...): Circular dependency detected while waiting for #{id}")
        continue

      unless callbacks[id]
        throw new Error("Dispatcher.waitFor(...): #{id} does not map to a registered callback.")

      invokeCallback(id)

  getActionToken = -> actionToken

  {dispatch, getActionToken, register, waitFor}

