class File
  constructor: (options)->
    @path = options

  resizeImage: (options={}, callbacks={})->
    parameters =
      filenameWithPath: @path
      format: options.format ? "png"
      compression: options.compression ? 1.0

    switch options.constraint
      when "width"
        parameters.size = { width: options.constraintLength }
      when "height"
        parameters.size = { height: options.constraintLength }
      else
        throw "unknown constraint name for steroids.file#resizeImage"

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
    parameters =
      filenameWithPath: @path
      path: options.destinationPath

    steroids.nativeBridge.nativeCall
      method: "unzip"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
