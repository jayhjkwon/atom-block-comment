module.exports =
  activate: ->
    atom.workspaceView.command "block-comment:toggle", => @toggle()

  toggle: ->
    workspace = atom.workspace
    editor = workspace.getActiveEditor()

    selection = editor.getSelection().getText()
    start = selection.trim().substr(0,2)
    end = selection.trim().substr(-2)

    if start is '/*' and end is '*/'
      replaced = selection.trim().substr(2)
      replaced = replaced.substr(0, replaced.length - 2)
      editor.insertText(replaced)
    else
      editor.insertText("/*#{selection}*/")

    # cursorPoint = editor.getCursorBufferPosition()
    # previousText = editor.getTextInBufferRange([[0, 0], [cursorPoint.row, cursorPoint.column]])
    # console.log "previousText=#{previousText}"
    # restText = editor.getTextInBufferRange([[cursorPoint.row, cursorPoint.column], [editor.getLastBufferRow(), -1]])
    # console.log "restText=#{restText}"
