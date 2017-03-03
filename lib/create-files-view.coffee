# @author xiaoshu.wb
# @version 1.0.0
# @see
# @Time 2017-02-09 Cambridge Guildholl

module.exports =
{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'
{CreateFileType} = require './create-files-type-select'
$ = window.$ = window.jQuery = require 'jquery'
require './jquery-ui.js'

module.exports =
class CreateFilesView

  filenameAndpath = null
  isAnimation = false

  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('create-files')

    # Create message element
    message = document.createElement('div')

    @filenameAndpath = new TextEditorView(mini: true,placeholderText:'Please input you file name and path')
    @filenameAndpath.id = 'thera-create-file-textedit'
    console.log(@filenameAndpath)

    message.textContent = "Add a file to.."

    message.classList.add('titleCreateFile')
    message.appendChild(atom.views.getView(@filenameAndpath))
    @createFileType = new CreateFileType(@filenameAndpath)
    message.appendChild(atom.views.getView(@createFileType))

    @element.appendChild(message)

    atom.views.getView(@filenameAndpath).addEventListener 'keydown', (e) => @noteOn(e)

    @filenameAndpath.focus()
    @filenameAndpath.on 'blur', ->
      anima = $("#createfiles").attr("isAnimation")
      if(anima != "true")
        atom.commands.dispatch(atom.views.getView(atom.workspace), "create-files:esc")


    #@element.appendChild(atom.views.getView(@filenameAndpath))
    #@element.appendChild(atom.views.getView(@createFileType))

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  initialize: ->
    super
    @filenameAndpath.focus()

  noteOn: (event) ->

    switch
      when event.keyIdentifier == 'Enter' then atom.commands.dispatch(atom.views.getView(atom.workspace), "create-files:tremble", @filenameAndpath.getText())
      when event.keyIdentifier == 'U+001B' then atom.commands.dispatch(atom.views.getView(atom.workspace), "create-files:esc")

      else return


  updatePath:(textContent) ->
    @filenameAndpath.focus()
    if(textContent)
      @filenameAndpath.setText textContent


  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
