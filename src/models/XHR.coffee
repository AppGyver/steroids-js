# XHR Description
class XHR extends NativeObject
  headers: []

  # ### new Steroids.XHR
  constructor: ->
    @method = undefined
    @url = undefined
    @async = undefined

  open: (methodString, urlString, isAsync=true) ->
    @method = methodString
    @url = urlString
    @async = isAsync

  fetch: (options={}, callbacks={}) ->

    fullPath = "#{Steroids.app.path}/#{options.filename}"

    @nativeCall
      method: "downloadFile"
      parameters:
        url: options.url || @url
        filenameWithPath: fullPath
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
