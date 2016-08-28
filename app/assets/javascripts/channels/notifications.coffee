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
      $('#chat_activity_area').prepend(this.createHtmlBlock(data))

      if data.existing_notifications
        $('#chat_activity_area').prepend(this.createHtmlBlock(notification)) for notification in data.existing_notifications

    createHtmlBlock: (data) ->
      { body, read, created_at } = data.notification
      { user } = data.user
      { sender } = data.sender
      block = """
         <div class="inbox_message" id="invitation">
          <div class="msg_from_pic">
            <img src='""" + data.sender.avatar + """' />
          </div>
          <div class="msg_info_from">
            <h5>Chatroom Activity</h5>
            <h6>""" + created_at + """</h6>
          </div>
          <div class="inbox_msg_area">
            <p><b>""" + data.user.username + """</b> wrote: """ + body + """</p>
          </div>
          <div class="dropdown_btn_area">
            <div class="inviteicon">
              <i class="fa fa-comments"></i>
            </div>
          </div>
        </div>
      """
      block

    getNotifications: ->
      @perform 'get_notifications'
