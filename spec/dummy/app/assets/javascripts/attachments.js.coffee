jQuery ->

  # Intercept form submission
  $(document).on 'submit', 'form#new_attachment', (e) ->
    e.preventDefault()

    # Hack for rails to submit form containing file input field
    $.ajax
      url: $(this).attr("action")
      type: "POST"
      data: $(this).serialize()
      dataType: 'json'
    .success (data)->
      if top.tinymce.activeEditor
        top.tinymce.activeEditor.insertContent('<img src="' + data.url + '"/>')
      else
        console.debug(data.url);

    .error (data)->
      if top.tinymce.activeEditor
        top.tinymce.activeEditor.notificationManager.open
          text: data.responseJSON.join('.')
          icon: 'help'
      else
        console.debug(data);

    .complete ->
      if top.tinymce.activeEditor
        top.tinymce.activeEditor.windowManager.close()
