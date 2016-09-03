getState = ->
  messages: App.chatroomStore.getMessages()

App.component.chatMessageWrapper = React.createClass
  getInitialState: ->
    getState()

  componentDidMount: ->
    App.chatroomStore.addChangeListener(this.onChange)
  
  componentWillUnmount: ->
    App.chatroomStore.removeChangeListener(this.onChange)

  onChange: ->
    this.setState getState()

  render: ->
    messages =
      for message in this.state.messages
        `<App.component.chatMessage message={message.message} user={message.user} key={message.message.id} />`

    `(
      <div>
        {messages}
      </div>
    )`