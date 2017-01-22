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
    else if extension is 'coffee'
      commentStart = '###'
      commentEnd = '###'
    else if extension is 'html'
      commentStart = '<!--'
      commentEnd = '-->'
    else if extension is 'php'
      commentStart = '/**\n
      \t * Block comment\n
      \t *\n
      \t * @param type\n
      \t * @return void\n'
      commentEnd = '\t */\n\t'
    else if extension is 'sml'
      commentStart = '(*'
      commentEnd = '*)'
    else if extension is 's'
      commentStart = '#'
      commentEnd = '#'
    else
      commentStart = '/*'
      commentEnd = '*/'

    selection = editor.getLastSelection()
    selectionText = selection.getText()
    
    if selectionText.length is 0
        selection.cursor.moveToBeginningOfLine()
        selection.selectToEndOfLine()
        selectionText = selection.getText()


    start = selectionText.trim().substr(0, commentStart.length)
    end = selectionText.trim().substr(-1 * commentEnd.length)

    if start is commentStart and end is commentEnd
       replaced = selectionText.trim().substr(commentStart.length)
       replaced = replaced.substr(0, replaced.length - commentEnd.length)
       selection.insertText(replaced, {select: false})
       selection.cursor.moveToEndOfLine()
    else
      selection.insertText("#{commentStart+selectionText+commentEnd}", {select: false})

    # cursorPoint = editor.getCursorBufferPosition()
    # previousText = editor.getTextInBufferRange([[0, 0], [cursorPoint.row, cursorPoint.column]])
    # console.log "previousText=#{previousText}"
    # restText = editor.getTextInBufferRange([[cursorPoint.row, cursorPoint.column], [editor.getLastBufferRow(), -1]])
    # console.log "restText=#{restText}"
