jQuery ->
  checkPopupWin=(win, message)->
    if !win || win.closed || typeof win.closed == 'undefined'
        alert(message)
    else
        win.focus();
    false

  $('a[data-popup]').on 'click', (e)->
    e.preventDefault()

    url = $(this).attr('href')
    message = $(this).data('blockedMessage')
    options = $(this).data('options') || 'toolbar=0,scrollbars=1,location=0,status=1,menubar=0,resizable=1,width=500,height=300'
    callback = ->
      win = window.open url,'_blank', options
      checkPopupWin win, message

    setTimeout callback, 0

