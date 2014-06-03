module.exports =
  activate: ->
    atom.workspaceView.command "block-comment:toggle", => @toggle()

  toggle: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    # editor.insertText('Hello, World!')
    selection = editor.getSelection()
    editor.insertText("/*#{selection.getText()}*/")
