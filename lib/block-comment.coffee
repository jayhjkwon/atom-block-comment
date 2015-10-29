module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'block-comment:toggle': @toggle

  toggle: ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()

    fileName = editor.getTitle()
    extension = fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
    if extension == fileName
      extension = ''

    # comment types
    if extension is 'js'
      commentStart = '/*\n'
      commentEnd = '\n*/'
    else if extension is 'sh' or extension is 'yaml' or extension is ''
      commentStart = ''
      commentEnd = ''
    else if extension is 'coffee'
      commentStart = '###\n'
      commentEnd = '\n###'
    else if extension is 'html' or extension is 'md'
      commentStart = '<!--\n'
      commentEnd = '\n-->'
    else if extension is 'php'
      commentStart = '/**\n
      \t * Block comment\n
      \t *\n
      \t * @param type\n
      \t * @return void\n'
      commentEnd = '\t */\n\t'
    else
      commentStart = '/*\n'
      commentEnd = '\n*/'


    selection = editor.getLastSelection()
    selectionText = selection.getText()


    if extension is 'sh' or extension is 'yaml' or extension is ''
      # add '# ' to the beginning of each line
      selectionText = selectionText.replace /^/, "# "
      selectionText = selectionText.replace /\n/g, "\n# "

    start = selectionText.trim().substr(0, commentStart.length)
    end = selectionText.trim().substr(-1 * commentEnd.length)

    # insert text
    if start is commentStart and end is commentEnd
      replaced = selectionText.trim().substr(commentStart.length)
      replaced = replaced.substr(0, replaced.length - commentEnd.length)
      selection.insertText(replaced, {select: true})
    else
      selection.insertText(
        "#{commentStart+selectionText+commentEnd}",
        {select: true}
      )
