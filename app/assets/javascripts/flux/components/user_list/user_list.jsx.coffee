App.component.userListItem = React.createClass
  props:
    user: React.PropTypes.object

  render: ->
    user = this.props.user
    tags =
      if user.tags?.length > 0
        for tag in user.tags
          `<a href="#" key={tag}>#{tag}</a>`

    `(
      <div className="inbox_message user_list_col">
        <div className="msg_from_pic">
          <img src={App.assets.images.defaultUser} />
        </div>
        <div className="msg_info_from user_list_pos">
          <h5>{user.username}</h5>
          <span className="match_title">matching with:</span>
          <h6>12:49</h6>
        </div>
        <div className="inbox_msg_area user_list_pos">
          <div className="used_tags_list user_list_tag">
              {tags}
          </div>
          <span className="view_msg_user view_tog" id="view_msg_user">View message<i className="fa fa-angle-right"></i></span>
          <span className="view_msg_user hide_msg_user" id="hide_msg_user">Hide message<i className="fa fa-angle-up"></i></span>
          <i className="fa fa-user-plus add_friend_user_list"><span className="upside_tooltip_box follow_tool no_wrap tool_before_follow noselect" id="small_btns_pos">
            Add friend<div className="arrow-left"></div>
          </span></i>
          <i className="fa fa-paper-plane add_friend_user_list inv_friend_user_list"><span className="upside_tooltip_box follow_tool no_wrap tool_before_follow noselect" id="small_btns_pos">
            Invite<div className="arrow-left"></div>
          </span></i>
        </div>
        <div className="user_list_msg_area">
          <p>" This is a message taken from the chat window. #5v5 #diamond #ranked. Please add me as friend or invite me. "</p>
        </div>
      </div>
    )`
