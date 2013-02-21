class PostMessage

  @postMessage: (message, targetOrigin) =>

    callbacks = {}

    jsonMessage = JSON.stringify(message)

    steroids.nativeBridge.nativeCall
      method: "broadcastJavascript"
      parameters:
        javascript: "steroids.PostMessage.dispatchMessageEvent('#{jsonMessage}', '*');"
      successCallbacks: [callbacks.onSuccess]
      recurringCallbacks: [callbacks.onFailure]


  @dispatchMessageEvent: (jsonMessage, targetOrigin) =>
    message = JSON.parse(jsonMessage)

    e = document.createEvent "MessageEvent"

    #                  type       bubles etc    message    origin
    e.initMessageEvent "message", false, false, message, "", "", window, null

    window.dispatchEvent e
