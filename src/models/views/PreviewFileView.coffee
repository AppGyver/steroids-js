class PreviewFileView

  constructor: (options={})->
    @filePath = if options.constructor.name == "String"
      options
    else
      options.filePath

    @relativeTo = options.relativeTo ? steroids.app.path

  getNativeFilePath: ->
    "#{@relativeTo}/#{@filePath}"
