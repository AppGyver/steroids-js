# Communication bridge for the new FreshAndroidBridge
# utilizes an android java class exposed to the webview itself
class FreshAndroidBridge extends Bridge
  constructor: ()->
  	FreshAndroidAPIBridge.registerHandler "steroids.nativeBridge.message_handler"

  	return true

  @isUsable: ()->
    # FreshAndroidAPIBridge is a java class exposed to webview
    return typeof FreshAndroidAPIBridge != 'undefined'

  sendMessageToNative:(message)->
    FreshAndroidAPIBridge.send message

  # notify the callbacks
  # msg is a JSON object
  message_handler: (msg)=>
    if msg?.callback?
      if @callbacks[msg.callback]?
        @callbacks[msg.callback].call(msg.parameters, msg.parameters)