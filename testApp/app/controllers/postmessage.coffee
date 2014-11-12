class window.PostmessageController

  @testListenMessages: ->
    receiveMessage = (message) ->
      steroids.logger.log message
      elem = document.createElement "p"
      elem.textContent = message.data.text
      document.body.appendChild elem

    window.addEventListener "message", receiveMessage

    alert "Listening for messages and appending them to this document."

  @testSendingUncommonCharacters: ->
    msg = {text: "%=!=€%&hay'jay  ____dolan"}
    window.postMessage msg, "*"

  @testSendHello: ->
    msg = { text: "hello!" }
    window.postMessage msg, "*"

  @testPushLayerAndSendMessage: ->
    pushView = (daview) ->
      steroids.layers.push daview,
        onSuccess: () ->
          window.setTimeout =>
            window.postMessage { text: "[2/2] this message is sent from onSuccess with a 100ms timeout" }, "*"
          , 100

          window.postMessage { text: "[1/2] hi this is sent from push onSuccess without a timeout" }, "*"
        onFailure: ->
          navigator.notification.alert "FAILURE in testPushLayerAndSendMessage failed to push layer"

    webView = new steroids.views.WebView "views/postmessage/listener.html"

    webView.preload {}, {
      onSuccess: ->
        pushView(webView)
      onFailure: ->
        steroids.logger.log "in testPushLayerAndSendMessage failed to preload layer, trying to push......."
        pushView(webView)
    }


  @testStressPostMessages: ->
    steroids.logger.log "TEST START starting postMessage stress test"

    # number of post messages sent:
    i = 500

    while i -= 1
      msg = { text: "Stress test message, #{i} messages left" }
      window.postMessage msg, "*"

    lul = { text: "STRESS TEST END" }
    window.postMessage lul, "*"

    steroids.logger.log "TEST END and SUCCESS, survived the stress test of postMessages"
