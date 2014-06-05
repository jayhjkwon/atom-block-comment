module.exports =
  activate: ->
    atom.workspaceView.command "block-comment:toggle", => @toggle()

  toggle: ->
    workspace = atom.workspace
    editor = workspace.getActiveEditor()

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
    else
      commentStart = '/*'
      commentEnd = '*/'

    selection = editor.getSelection().getText()
    start = selection.trim().substr(0, commentStart.length)
    end = selection.trim().substr('-' + commentEnd.length)

    if start is commentStart and end is commentEnd
      replaced = selection.trim().substr(commentStart.length)
      replaced = replaced.substr(0, replaced.length - commentEnd.length)
      editor.insertText(replaced)
    else
      editor.insertText("#{commentStart+selection+commentEnd}")





    # cursorPoint = editor.getCursorBufferPosition()
    # previousText = editor.getTextInBufferRange([[0, 0], [cursorPoint.row, cursorPoint.column]])
    # console.log "previousText=#{previousText}"
    # restText = editor.getTextInBufferRange([[cursorPoint.row, cursorPoint.column], [editor.getLastBufferRow(), -1]])
    # console.log "restText=#{restText}"
