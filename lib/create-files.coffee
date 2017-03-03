# @author xiaoshu.wb
# @version 1.0.0
# @see
# @Time 2017-02-09 Cambridge Guildholl


CreateFilesView = require './create-files-view'
{CompositeDisposable} = require 'atom'
$ = window.$ = window.jQuery = require 'jquery'
require './jquery-ui.js'
fs = require 'fs-extra'

module.exports = CreateFiles =
  createFilesView: null
  modalPanel: null
  subscriptions: null
  createFilesView: null
  createFilesViewelement: null

  activate: (state) ->
    @createFilesView = new CreateFilesView(state.createFilesViewState)

    @modalPanel = atom.workspace.addModalPanel(item: @createFilesView.getElement(), visible: false)

    @createFilesViewelement = atom.views.getView(@createFilesView)
    @createFilesViewelement.setAttribute("id", "createfiles")
    @createFilesViewelement.setAttribute("isAnimation", "false")

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'create-files:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'create-files:tremble': (text) => @tremble(text)
    @subscriptions.add atom.commands.add 'atom-workspace', 'create-files:esc': => @esc()


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @createFilesView.destroy()

  serialize: ->

  tremble: (text) ->
    filepath = text.detail
    fs.ensureFile(filepath, (err) =>
      if err
        atom.notifications.addError(err.message)

        $("#createfiles").attr("isAnimation",true)

        $("#createfiles").effect( "shake", {}, 250, ( ->
          $("#createfiles").attr("isAnimation",false)
          ) )
      else
        @modalPanel.hide()
        atom.workspace.open(filepath)
    )

  esc: ->
    @modalPanel.hide()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
      if(atom.project.getPaths)
        @createFilesView.updatePath atom.project.getPaths()[0] + "/NewFile"
      #if(atom.workspace.getActiveTextEditor() && atom.workspace.getActiveTextEditor().getPath())
      #  @path = atom.workspace.getActiveTextEditor().getPath()
      #  @createFilesView.updatePath(@path + "NewFile")
      #else
      #  @createFilesView.updatePath atom.project.getPaths()[0]
