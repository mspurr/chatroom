App.component.chatMessage = React.createClass
  props:
    chatMessage: React.PropTypes.object
    user: React.PropTypes.user

  render: ->
    `(
      <div className="user_chat_message">
        <div className="chat_msg_sender">
          <img className='chat_user_img' src={App.assets.images.defaultUser} />
          <a href="#"><span className="comment_header chat_msg_username">{user.username}</span></a><span>:</span>
        </div>
        <div className="user_msg_info">
          <p>{chatMessage.time}</p>
        </div>
        <div className="user_chat_msg_div">
          <p className="user_chat_msg_p">{chatMessage.body}</p>
        </div>
      </div>
    )`