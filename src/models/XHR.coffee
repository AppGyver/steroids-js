# XHR Description
class XHR
  headers: []

  # ### new Steroids.XHR
  constructor: ->
    @method = undefined
    @url = undefined
    @async = undefined

    @status = 0
    @readyState = 0
    @headers = {}

  open: (methodString, urlString, isAsync=true) ->
    @method = methodString
    @url = urlString
    @async = isAsync


  send: (data) =>
    throw "Error: INVALID_STATE_ERR: DOM Exception 11" unless @method and @url

    throw "Method not implemented" unless @method == "GET"

    @fetch
      url: @url
      filenameWithPath: "temp"
      headers: @headers

  setRequestHeader: (name, value) =>
    @headers[name] = value


  fetch: (options={}, callbacks={}) ->
    destinationPath = if options.constructor.name == "String"
      options
    else
      options.absoluteDestinationPath

    steroids.nativeBridge.nativeCall
      method: "downloadFile"
      parameters:
        url: options.url || @url
        headers: options.headers || @headers
        filenameWithPath: destinationPath
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
