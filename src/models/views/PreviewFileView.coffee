class PreviewFileView

  constructor: (options={})->
    @file = if options.constructor.name == "String"
      options
    else
      options.file
