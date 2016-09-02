App.component.chatMessage = React.createClass
  props:
    chatMessage: React.PropTypes.object

  render: ->
    # { message, user } = this.props.chatMessage
    user = this.props.user
    message = this.props.message
    console.log "chat_message"
    console.log message
    console.log user
    time = new Date(message.created_at)

    username = `<span className="comment_header chat_msg_username">{user.username}</span>`
    userImage = `<img className='chat_user_img' src={App.assets.images.defaultUser} />`

    `(
      <div className="user_chat_message">
        <div className="chat_msg_sender">
          {userImage}
          <a href="#">{username}</a><span>:</span>
        </div>
        <div className="user_msg_info">
          <p>{time.getHours()}:{time.getMinutes()}</p>
        </div>
        <div className="user_chat_msg_div">
          <p className="user_chat_msg_p">{message.body}</p>
        </div>
      </div>
    )`
