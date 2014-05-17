# Communication bridge that utilizes an Object-C class exposed to the webview itself
class JSCoreBridge extends Bridge
  constructor: ()->
    return true

  @isUsable: ()->
    # __JSCoreAPIBridge is a Objective-C class (JSCoreBridge.m) exposed to the webview
    return true

  sendMessageToNative:(message)->
    # Ensure websocket is open before sending anything
    if window.__JSCoreBridgeImpl?
      window.__JSCoreBridgeImpl.send message
    else
      window.steroids.on "jsCoreBridgeUsable", ()=>
        window.__JSCoreBridgeImpl.send message

  parseMessage: (message={})->
    #JSON.stringify(message)
    #no need to turn into string for iOS
    message

  # the message_handler function is called from iOS native code
  # in a the main thread (which is different from the event loop thread
  # running the in the JavaScriptCore in the webView)
  # and it can cause issues with some
  # js operations.. displaying a window.alert() for example
  # so this executeInWebThread function is called with a setTimout
  # of 1 milisecond. executeInWebThread is executed in the correct
  # thread by the webKit event loop internals.
  executeInWebThread: (msg)=>
    # iOS parameters come as objects and not as Strings
    if msg?.callback?
      if @callbacks[msg.callback]?
        @callbacks[msg.callback].call(msg.parameters, msg.parameters)

  message_handler: (msg)=>
    setTimeout ()=>
        @executeInWebThread msg
      ,
        1
