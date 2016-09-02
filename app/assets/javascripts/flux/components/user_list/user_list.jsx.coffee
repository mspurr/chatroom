# TODO: Figure out timezoning stuff
date_options = {
  hour: "2-digit", minute: "2-digit", timeZone: "America/Chicago"
}

App.component.userListItem = React.createClass
  props:
    user: React.PropTypes.object

  getInitialState: ->
    messageExpanded: false

  toggleExpand: ->
    this.setState messageExpanded: (not this.state.messageExpanded)

  render: ->
    user = this.props.user
    time = new Date(user.created_at).toLocaleDateString("en-US", date_options)
    tags =
      if user.tags?.length > 0
        for tag in user.tags
          `<a href="#" key={tag}>#{tag}</a>`
    expanded = this.state.messageExpanded

    message = if expanded
      `(
        <div className="user_list_msg_area">
          <p>" This is a message taken from the chat window. #5v5 #diamond #ranked. Please add me as friend or invite me. "</p>
        </div>
      )`

    expandButton = if expanded
      `<span className="view_msg_user hide_msg_user" id="hide_msg_user" onClick={this.toggleExpand}>Hide message<i className="fa fa-angle-up"></i></span>`
    else if user.tags?.length > 0
      `<span className="view_msg_user view_tog" id="view_msg_user" onClick={this.toggleExpand}>View message<i className="fa fa-angle-right"></i></span>`
      
    
    socialButtons = if expanded and user.tags?.length > 0
      `(
        <div>
          <i className="fa fa-user-plus add_friend_user_list"><span className="upside_tooltip_box follow_tool no_wrap tool_before_follow noselect" id="small_btns_pos">
            Add friend<div className="arrow-left"></div>
          </span></i>
          <i className="fa fa-paper-plane add_friend_user_list inv_friend_user_list"><span className="upside_tooltip_box follow_tool no_wrap tool_before_follow noselect" id="small_btns_pos">
            Invite<div className="arrow-left"></div>
          </span></i>
        </div>
      )`

    matchingWith =
      if user.tags?.length > 0
        `(
          <div>
            <span className="match_title">matching with:</span>
            <h6>{time}</h6>
          </div>
        )`


    `(
      <div className="inbox_message user_list_col">
        <div className="msg_from_pic">
          <img src={App.assets.images.defaultUser} />
        </div>
        <div className="msg_info_from user_list_pos">
          <h5>{user.username}</h5>
          {matchingWith}
        </div>
        <div className="inbox_msg_area user_list_pos">
          <div className="used_tags_list user_list_tag">
              {tags}
          </div>
          {expandButton}
          {socialButtons}
        </div>
        {message}
      </div>
    )`
