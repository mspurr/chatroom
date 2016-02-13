$ ->
  textArea = $('textarea[name="message"]')

  $('#submitMessage').click ->
    App.game.speak textArea.val().replace( /[\s\n\r]+/g, ' ' )

  textArea.focus ->
    $(this).keydown (e) ->
      if e.which is 13
        message = $(this).val().split('\n')
        for line in message
          if line isnt ''
            App.game.speak line
        textArea.val(null)
