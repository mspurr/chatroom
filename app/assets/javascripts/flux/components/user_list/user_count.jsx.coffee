getState = ->
  userCount: App.userStore.getUserCount()

App.component.userCount = React.createClass
  props:
    game: React.PropTypes.string

  getInitialState: ->
    getState()

  componentDidMount: ->
    App.userStore.addChangeListener(this.onChange)

  componentWillUnount: ->
    App.userStore.removeChangeListener(this.onChange)

  onChange: ->
    this.setState getState()

  render: ->
    console.log this.state.userCount

    `(
      <div className="chat_title_info">
        <p><i className="fa fa-gamepad"></i>Game: {this.props.game}</p>
        <p> |</p>
        <p><i className="fa fa-keyboard-o"></i>Platform: Computer</p>
        <p> |</p>
        <p>
          <i className="fa fa-users"></i>Current users: {this.state.userCount}
        </p>
      </div>
    )`
