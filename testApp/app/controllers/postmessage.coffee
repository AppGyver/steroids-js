class window.PostmessageController

  @testListenMessages: ->
    receiveMessage = (message) ->
      steroids.logger.log message
      elem = document.createElement "p"
      elem.textContent = message.data.text
      document.body.appendChild elem

    window.addEventListener "message", receiveMessage

    navigator.notification.alert "Listening for messages and appending them to this document."

  @testSendingUncommonCharacters: ->
    msg = {text: "%=!=€%&hay'jay  ____dolan"}
    window.postMessage msg, "*"

  @testSendHello: ->
    msg = { text: "hello!" }
    window.postMessage msg, "*"

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
