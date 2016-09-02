getState = ->
  messages: App.chatroomStore.getMessages()

App.component.chatMessageWrapper = React.createClass
  getInitialState: ->
    getState()

  componentDidMount: ->
    App.chatroomStore.addChangeListener(this.onChange)
  
  componentDidUnmount: ->
    App.chatroomStore.removeChangeListener(this.onChange)

  onChange: ->
    getState()

  render: ->
    messages =
      for message in this.state.messages
        `<App.component.chatMessage message={message} />`

    `(
      <div>
        {messages}
      </div>
    )`