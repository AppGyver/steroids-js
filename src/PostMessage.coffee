isMobile = /AppGyver|Crosswalk/.test(navigator.userAgent)

class PostMessage

  @originalPostMessage: do (win = window)->
    original = win.postMessage
    (args...)->
      if args.length and !args[1]?
        args[1] = "*"
      try
        original.apply win, args
      catch e
        console.log "Could not pass postMessage to original window.postMessage: #{e}", args[0]

  # Switch between native and web implementations for postMessage dispatching.
  # If we are in web, there's no native bridge to dispatch messages.
  # If we are in mobile, we don't want to dispatch through window as well;
  # we would get duplicate postMessage events in the originating window.
  @postMessage: switch
    when !isMobile
      @originalPostMessage
    else
      (message, targetOrigin) =>
        escapedJSONMessage = escape(JSON.stringify(message))

        steroids.nativeBridge.nativeCall
          method: "broadcastJavascript"
          parameters:
            javascript: "steroids.PostMessage.dispatchMessageEvent('#{escapedJSONMessage}', '*');"
          successCallbacks: []
          failureCallbacks: []
          recurringCallbacks: []

  @dispatchMessageEvent: (escapedJSONMessage, targetOrigin) =>
    #wrap in a setTimeout to garantee that runs in the webkit thread.
    setTimeout ->
      message = JSON.parse(unescape(escapedJSONMessage))

      e = document.createEvent "MessageEvent"

      #                  type       bubles etc    message    origin
      e.initMessageEvent "message", false, false, message, "", "", window, null

      window.dispatchEvent e
    ,
      1
