class MediaGalleryView

  constructor: (options={})->
    @files = if options.constructor.name == "Array"
      options
    else
      options.files

    @relativeTo = options.relativeTo ? steroids.app.path

  getNativeFilePath: => @files.map (file)=>
    if /^http.*/.test(file)
      file
    else
      "#{@relativeTo}/#{file}"
