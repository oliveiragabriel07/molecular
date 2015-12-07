(function() {
  'use strict'

  tinymce.create('tinymce.plugins.ImageUplad', {
    init: function(editor, url) {
      var self = this;
      self.editor = editor;

      function openDialog() {
        editor.windowManager.open({
          title: 'Upload Image',
          url: '/attachments/new', // TODO: receive upload image url as parameter
          width: 500,
          height: 300
        }, {
          plugin: self
        });
      }

      editor.addButton('imageupload', {
        icon: 'image',
        tooltip: 'Insert/edit image',
        onclick: openDialog,
        stateSelector: 'img:not([data-mce-object],[data-mce-placeholder]),figure.image'
      });

      editor.addMenuItem('imageupload', {
        icon: 'image',
        text: 'Insert/edit image',
        onclick: openDialog,
        context: 'insert',
        prependToContext: true
      });
    }
  });

  // Register plugin
  tinymce.PluginManager.add('imageupload', tinymce.plugins.ImageUplad);
})();
