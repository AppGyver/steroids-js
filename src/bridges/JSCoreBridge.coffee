# Communication bridge that utilizes an Object-C class exposed to the webview itself
class JSCoreBridge extends Bridge
  constructor: ()->
    #window.AG_SCREEN_ID = window.__JSCoreBridgeImpl.getAGScreenId()
    #window.AG_LAYER_ID = window.__JSCoreBridgeImpl.getAGLayerId()
    #window.AG_VIEW_ID = window.__JSCoreBridgeImpl.getAGViewId()

    return true

  @isUsable: ()->
    # __JSCoreAPIBridge is a Objective-C class (JSCoreBridge.m) exposed to the webview
    console.log "JSCoreBridge.isUsable: #{typeof window.__JSCoreBridgeImpl}"
    return typeof window.__JSCoreBridgeImpl != 'undefined'

  sendMessageToNative:(message)->
    window.__JSCoreBridgeImpl.send message

  parseMessage: (message={})->
    #JSON.stringify(message)
    #no need to turn into string for iOS
    message
