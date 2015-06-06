describe 'filling line', ->
  [workspaceView, editor, activationPromise] = []

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open('sample.js')

    waitsForPromise ->
      atom.packages.activatePackage('atom-fill-line')

    runs ->
      workspaceView = atom.views.getView(atom.workspace)
      editor = atom.workspace.getActiveTextEditor()
      editor.selectAll();
      editor.backspace();

  it 'empty editor should do nothing', ->
    editor.setText ''
    atom.commands.dispatch(workspaceView, 'fill-line')
    expect(editor.getText()).toBe ''

  it 'one line editor should do nothing', ->
    editor.setText 'WorkspaceView'
    editor.moveToBottom()
    editor.moveToEndOfLine()
    atom.commands.dispatch(workspaceView, 'fill-line')
    expect(editor.getText()).toBe 'WorkspaceView'

  it 'should duplicate character to length of line above', ->
    editor.setText 'WorkspaceView\n+'
    editor.moveToBottom()
    editor.moveToEndOfLine()
    atom.commands.dispatch(workspaceView, 'fill-line')
    expect(editor.getText()).toBe 'WorkspaceView\n+++++++++++++'

  it 'should duplicate string to length of line above', ->
    editor.setText 'WorkspaceView\n+-~'
    editor.moveToBottom()
    editor.moveToEndOfLine()
    atom.commands.dispatch(workspaceView, 'fill-line')
    expect(editor.getText()).toBe 'WorkspaceView\n+-~+-~+-~+-~+'
