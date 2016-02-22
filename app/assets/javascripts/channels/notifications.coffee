App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log "Notifications channel connected!"
    $().load(this.getNotifications())

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log "Notifications channel disconnected!"

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    existing_notifications = data['existing_notifications']
    if data['existing_notifications']
      $('#notifications').html(null)
      for notification in existing_notifications
        $('#notifications').append(this.createHtmlBlock(notification))
    $('#num_notifications').text existing_notifications.length

  createHtmlBlock: (notification) ->
    notificationDate = new Date(notification.created_at)
    block = '''
    <div class="inbox_message" id="unread">
      <div class="msg_from_pic">
        <img src="''' + notification.sender.avatar + '''" />
      </div>
      <div class="msg_info_from">
        <h5>''' + notification.sender.username + '''</h5>
        <h6>''' + notificationDate.getHours() + ":" + notificationDate.getMinutes() + '''</h6>
      </div>
      <div class="inbox_msg_area">
        <p>''' + notification.content + '''</p>
      </div>
    </div>
    '''
    block

  notificationRead: (notification) ->
    @perform 'notification_read', notification: notification

  getNotifications: ->
    @perform 'get_notifications'
