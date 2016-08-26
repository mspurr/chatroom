$(document).ready ->
  App.notifications = App.cable.subscriptions.create "NotificationsChannel",
    connected: ->
      console.log "Notifications connected"
      $().load(this.getNotifications())
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel 
      console.log "Received Notification!"
      $('#private-message-inbox').prepend(this.createHtmlBlock(data))

      console.log "Existing Notfication!"
      console.log data.existing_notifications

      if data.existing_notifications
        $('#private-message-inbox').prepend(this.createHtmlBlock(notification)) for notification in data.existing_notifications

    createHtmlBlock: (data) ->
      { body, read, created_at } = data.notification
      { user } = data.user
      { sender } = data.sender
      console.log data.notification
      console.log data.user
      console.log data.sender
      block = """
        <div class="inbox_message" id="read">
          <div class="msg_from_pic">
            <img src='""" + data.sender.avatar_file_name + """' />
          </div>
          <div class="msg_info_from">
            <h5>""" + data.user.username + """</h5>
            <h6>""" + created_at + """</h6>
          </div>
          <div class="inbox_msg_area">
            <p>""" + body + """</p>
          </div>
        </div>
      """
      block

    getNotifications: ->
      @perform 'get_notifications'
