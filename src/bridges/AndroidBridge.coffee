# Communication bridge that utilizes an android java class exposed to the webview itself
class AndroidBridge extends Bridge
  constructor: ()->
    AndroidAPIBridge.registerHandler("steroids.nativeBridge.message_handler")

    window.AG_SCREEN_ID = AndroidAPIBridge.getAGScreenId()
    window.AG_LAYER_ID = AndroidAPIBridge.getAGLayerId()
    window.AG_VIEW_ID = AndroidAPIBridge.getAGViewId()

    return true

  @isUsable: ()->
    # AndroidAPIBridge is a java class exposed to webview
    return typeof AndroidAPIBridge != 'undefined'

  sendMessageToNative:(message)->
    AndroidAPIBridge.send message
