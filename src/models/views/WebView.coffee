class WebView extends NativeObject

  constructor: (options)->
    super()
    @location = options.location

    if @location.indexOf("://") == -1 # if a path
      if window.location.href.indexOf("file://") == -1 # if not currently on file protocol
        @location = "#{window.location.protocol}//#{window.location.host}/#{@location}"

    @pushAnimation = options.pushAnimation if options.pushAnimation?
    @pushAnimationDuration = options.pushAnimationDuration if options.pushAnimationDuration?
    @popAnimation = options.popAnimation if options.popAnimation?
    @popAnimationDuration = options.popAnimationDuration if options.popAnimationDuration?

    @params = @getParams()

  params: {}

  getParams: ()->
    params = {}
    pairStrings = @location.slice(@location.indexOf('?') + 1).split('&')
    for pairString in pairStrings
      pair = pairString.split '='
      params[pair[0]] = pair[1]
    return params
