class WebView

  params: {}
  id: null
  location: null

  navigationBar: new NavigationBar

  constructor: (options={})->
    @location = if options.constructor.name == "String"
      options
    else
      options.location

    if @location.indexOf("://") == -1 # if a path
      if window.location.href.indexOf("file://") == -1 # if not currently on file protocol
        @location = "#{window.location.protocol}//#{window.location.host}/#{@location}"

    @params = @getParams()


  preload: (options={}, callbacks={}) ->
    steroids.debug "preload called for WebView #{JSON.stringify @}"

    proposedId = @location || options.id

    setIdOnSuccess = () =>
      steroids.debug "preload success: setting id"
      @id = proposedId

    steroids.nativeBridge.nativeCall
      method: "preloadLayer"
      parameters:
        id: proposedId
        url: @location || options.location
      successCallbacks: [setIdOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getParams: ()->
    params = {}
    pairStrings = @location.slice(@location.indexOf('?') + 1).split('&')
    for pairString in pairStrings
      pair = pairString.split '='
      params[pair[0]] = pair[1]
    return params
