App.component.userWrapper = React.createClass
  getInitialState: ->
    users: App.userStore.getUsers()

  componentDidMount: ->
    App.userStore.addChangeListener(this.onChange)

  componentWillUnmount: ->
    App.userStore.removeChangeListener(this.onChange)

  onChange: ->
    this.setState
      users: App.userStore.getUsers()

  render: ->
    console.log "USERS:"
    console.log this.state.users
    users =
      for user in this.state.users
        `<App.component.userListItem user={user} key={user.id} />`

    `(
      <div className="userwindow">
        <div className="chat_inside">
          <div className="users_pop_area">
            {users}
          </div>
          <span className="clear_list_btn">
            <i className="fa fa-times-circle"></i>Clear list
          </span>
          <span className="invite_all_btn">
            <i className="fa fa-paper-plane"></i>Invite All
          </span>
          <p className="window_tip">Use #hashtags in the chatwindow to match with other users. Users matching your hashtags will appear above.</p>
        </div>
      </div>
    )`
