$ ->
  $('.chat_input_div, button').click ->
    App.game.speak $('textarea[name="message"]').val()
