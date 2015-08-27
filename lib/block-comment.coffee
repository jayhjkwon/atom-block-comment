module.exports =
  activate: ->
    atom.commands.add 'atom-workspace', 'block-comment:toggle': @toggle

  toggle: ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()

    fileName = editor.getTitle()
    extension = fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
    if extension is 'js'
      commentStart = '/*'
      commentEnd = '*/'
    else if extension is 'sh' or extension is 'yaml'
      commentStart = ''
      commentEnd = ''
    else if extension is 'coffee'
      commentStart = '###'
      commentEnd = '###'
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
      commentStart = '/*'
      commentEnd = '*/'

    selection = editor.getLastSelection()
    selectionText = selection.getText()

    if extension is 'sh' or extension is 'yaml'
      # add '# ' to the beginning of each line
      selectionText = selectionText.replace /^/, "# "
      selectionText = selectionText.replace /\n/g, "\n# "

    start = selectionText.trim().substr(0, commentStart.length)
    end = selectionText.trim().substr(-1 * commentEnd.length)

    if start is commentStart and end is commentEnd
      replaced = selectionText.trim().substr(commentStart.length)
      replaced = replaced.substr(0, replaced.length - commentEnd.length)
      selection.insertText(replaced, {select: true})
    else
      selection.insertText("#{commentStart+selectionText+commentEnd}", {select: true})





    # cursorPoint = editor.getCursorBufferPosition()
    # previousText = editor.getTextInBufferRange([[0, 0], [cursorPoint.row, cursorPoint.column]])
    # console.log "previousText=#{previousText}"
    # restText = editor.getTextInBufferRange([[cursorPoint.row, cursorPoint.column], [editor.getLastBufferRow(), -1]])
    # console.log "restText=#{restText}"
