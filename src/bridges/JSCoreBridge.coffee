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

  message_handler: (msg)=>
    # iOS parameters come as objects and not as Strings
    if msg?.callback?
      if @callbacks[msg.callback]?
        @callbacks[msg.callback].call(msg.parameters, msg.parameters)