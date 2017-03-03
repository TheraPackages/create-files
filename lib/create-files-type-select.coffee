# @author xiaoshu.wb
# @version 1.0.0
# @see all of file class type
# @Time 2017-02-09 Cambridge Guildholl

{SelectListView, $$,$} = require 'atom-space-pen-views'
$ = require 'path'


module.exports =
CreateFileType: class CreateFileType extends SelectListView

 createFileType = null

 initialize: (createFileTypestate) ->
   super
   @setItems([{icon: 'icon text-icon medium-blue', title: 'blank',suffix:""},{icon: 'icon word-icon light-blue', title: 'WEEX(.we)',suffix:".we"},{icon: 'icon js-icon medium-yellow', title: 'Javascript(.js)',suffix:".js"},{icon: 'icon vue-icon light-green', title: 'Vue(.vue)',suffix:".vue"},{icon: 'icon lua-icon medium-red', title: 'Lua(.lua)',suffix:".lua"},{icon: 'icon css3-icon dark-blue', title: 'Css3(.css)',suffix:".css"},{icon: 'icon css3-icon medium-maroon', title: 'Less(.less)',suffix:".less"},{icon: 'icon npm-icon medium-red', title: 'Json(.json)',suffix:".json"},{icon: 'icon markdown-icon medium-blue', title: 'Markdown(.md)',suffix:".md"}])
   @filterEditorView.hide()
   @createFileType = createFileTypestate

 viewForItem: (item) ->
   $$ ->
     @li =>
       #<a class="list-group-item" href="#"><i class="fa fa-home fa-fw" aria-hidden="true"></i>&nbsp; Home</a>
        @i class:item.icon
        @span item.title


 confirmed: (item) ->

   #to insure path was valid
   #@path = atom.workspace.getActiveTextEditor().getPath()

   #console.log @path
   @currentText = @createFileType.getText()

   #首先判断是否为空
   if(@currentText)
    dirmap  = $.parse(@currentText)

    tempdir = $.format(
          dir: dirmap.dir
          name: dirmap.name
          ext: item.suffix)


    @createFileType.setText(tempdir)

   #如果不为空的情况下，再判断是否存在后缀
   #如果有后缀
   #如果没有后缀

   @createFileType.focus()


 cancelled: ->
   console.log("This view was cancelled")
