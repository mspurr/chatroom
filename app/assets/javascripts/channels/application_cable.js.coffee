#= require action_cable

@App = {}
# App.cable = ActionCable.createConsumer 'ws://localhost:28080'
App.cable = ActionCable.createConsumer '/cable'
