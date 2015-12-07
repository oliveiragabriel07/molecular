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
        alert(data.url);

    .error (data)->
      alert(data)
    .complete ->
      if top.tinymce.activeEditor
        top.tinymce.activeEditor.windowManager.close()
