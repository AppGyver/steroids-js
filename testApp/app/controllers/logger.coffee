class window.LoggerController

  @index: ->
    steroids.navigationBar.show("logger")

  @testLog: ->
    steroids.logger.log "hello"

  @testException: ->
    asdf()

  @testShowLastMessage: ->
    lastMessage = steroids.logger.messages[steroids.logger.messages.length-1]
    if lastMessage?
      notification "Last message: #{lastMessage.message}"
    else
      notification "no messages!"

  @testStartFlushing: ->
    if steroids.logger.queue.startFlushing(100)
      notification "started"
    else
      alert "not started"

  @testStopFlushing: ->
    steroids.logger.queue.stopFlushing()

  @testCircularObject: ->
    circularObj =
      a: 'b'
    circularObj.circularRef = circularObj
    circularObj.list = [ circularObj, circularObj ]

    steroids.logger.log(circularObj)
