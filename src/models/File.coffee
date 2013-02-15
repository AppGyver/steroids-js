class File
  constructor: (options)->
    @path = if options.constructor.name == "String"
      options
    else
      options.path

    @relativeTo = options.relativeTo ? steroids.app.path

  resizeImage: (options={}, callbacks={})->
    unless @relativeTo == steroids.app.userFilesPath
      throw "Cannot resize images outside `steroids.app.userFilesPath`. Files must first be copied under application document root and then resized."

    userCompression = options.format?.compression ? 100
    nativeCompression = 1-(userCompression/100)

    parameters =
      filenameWithPath: "#{@relativeTo}/#{@path}"
      format: options.format?.type ? "jpg"
      compression: nativeCompression

    if options.constraint?
      switch options.constraint.dimension
        when "width"
          parameters.size = { width: options.constraint.length }
        when "height"
          parameters.size = { height: options.constraint.length }
        else
          throw "unknown constraint name"
    else
      throw "constraint not specified"

    steroids.nativeBridge.nativeCall
      method: "resizeImage"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # scaleImage: (options={}, callbacks={})->
  #   parameters =
  #     filenameWithPath: @path
  #     format: options.format ? "png"
  #     compression: options.compression ? 1.0
  #     scaleFactor: options.factor
  #
  #   @nativeCall
  #     method: "scaleImage"
  #     parameters: parameters
  #     successCallbacks: [callbacks.onSuccess]
  #     failureCallbacks: [callbacks.onFailure]

  unzip: (options={}, callbacks={})->
    sourcePath = "#{@relativeTo}/#{@path}"

    destinationPath = if options.constructor.name == "String"
      options
    else
      options.destinationPath

    parameters =
      filenameWithPath: sourcePath
      path: destinationPath

    steroids.nativeBridge.nativeCall
      method: "unzip"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
