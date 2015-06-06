module.exports = AtomFillLine =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'fill-line', ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?

      options = {}
      options.wordRegex = /^[\t ]*$|[^\s\/\\\(\)"':,\.;<>~!@#\$%\^&\*\|\+=\[\]\{\}`\?]+/g
      for cursor in editor.getCursors()
        position = cursor.getBufferPosition()

        prefix = cursor.getCurrentWordPrefix()

        lineAbove = editor.lineTextForBufferRow(position.row - 1)
        return unless lineAbove?

        newLine = prefix
        while newLine.length < lineAbove.length
          newLine += prefix
        range = cursor.getCurrentLineBufferRange()
        editor.setTextInBufferRange(range, newLine.substr(0, lineAbove.length))
