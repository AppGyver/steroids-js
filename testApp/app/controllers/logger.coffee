class window.LoggerController

  @index: ->
    steroids.navigationBar.show("logger")

  @testLog: ->
    steroids.logger.log "hello"
    @testShowLastMessage()

  @testException: ->
    asdf()

  @testShowLastMessage: ->
    lastMessage = steroids.logger.messages.pop()
    if lastMessage?
      alert "Last message: #{lastMessage.message}"
    else
      alert "no messages!"
