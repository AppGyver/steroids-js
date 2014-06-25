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
