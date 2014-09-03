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
      steroids.logger.log "SUCCESS Last message in log: #{lastMessage.message}"
    else
      steroids.logger.log "No messages in log! Not sure if failure or no previous log messages..."

  @testStartFlushing: ->
    if steroids.logger.queue.startFlushing(100)
      steroids.logger.log "SUCCESS in starting up logger queue flushing again"
    else
      steroids.logger.log "FAILURE in testStartFlushing, flushing did not start"

  @testStopFlushing: ->
    if steroids.logger.queue.stopFlushing()
      navigator.notification.alert "SUCCESS flushing was stopped - no new logs will appear. Test by pressing steroids.logger.log('hello')"
    else
      navigator.notification.alert "FAILURE in testStopFlushing"

  @testCircularObject: ->
    circularObj =
      a: 'b'
    circularObj.circularRef = circularObj
    circularObj.list = [ circularObj, circularObj ]

    steroids.logger.log(circularObj)
