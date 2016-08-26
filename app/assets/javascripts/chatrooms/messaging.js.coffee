$ ->
  textArea = $('textarea[name="message"]')

  truncateSend = (message) ->
    for line in message
      if line isnt ''
        App.chat.speak line
    textArea.val(null)

  $('#submitMessage').click ->
    message = textArea.val().split('\n')
    truncateSend(message)

  textArea.focus ->
    $(this).keydown (e) ->
      if e.which is 13
        message = $(this).val().split('\n')
        truncateSend(message)
