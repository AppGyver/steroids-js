# Communication bridge that utilizes an Object-C class exposed to the webview itself
class JSCoreBridge extends Bridge
  constructor: ()->
    window.__JSCoreBridgeImpl.registerHandler("steroids.nativeBridge.message_handler")

    #window.AG_SCREEN_ID = window.__JSCoreBridgeImpl.getAGScreenId()
    #window.AG_LAYER_ID = window.__JSCoreBridgeImpl.getAGLayerId()
    #window.AG_VIEW_ID = window.__JSCoreBridgeImpl.getAGViewId()

    return true

  @isUsable: ()->
    # __JSCoreAPIBridge is a Objective-C class (JSCoreBridge.m) exposed to webview
    console.log "JSCoreBridge.isUsable: #{typeof window.__JSCoreBridgeImpl}"
    return typeof window.__JSCoreBridgeImpl != 'undefined'

  sendMessageToNative:(message)->
    window.__JSCoreBridgeImpl.send message

  send: (options={})=>
    # no need to serialize the callbacks into identifiers of string
    #callbacks = @storeCallbacks(options)

    # Build the request object for native API
    request =
      method: options.method
      parameters: if options?.parameters? then options.parameters else {}
      callbacks: options.callbacks

    # Add context parameters
    request.parameters["view"] = window.top.AG_VIEW_ID
    request.parameters["screen"] = window.top.AG_SCREEN_ID
    request.parameters["layer"] = window.top.AG_LAYER_ID
    request.parameters["udid"] = window.top.AG_WEBVIEW_UDID

    #@sendMessageToNative JSON.stringify(request)
    @sendMessageToNative request