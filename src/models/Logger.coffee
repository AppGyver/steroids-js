class Logger

  class LogMessage

    constructor: (@message) ->
      @location = window.location.href
      @screen_id = window.AG_SCREEN_ID
      @layer_id = window.AG_LAYER_ID
      @view_id = window.AG_VIEW_ID


      @date = new Date()

    asJSON: ->
      try
        messageJSON = JSON.stringify(@message)
      catch err
        messageJSON = err.toString()

      obj =
        message: messageJSON
        location: @location
        date: @date.toJSON()
        screen_id: @screen_id
        layer_id: @layer_id
        view_id: @view_id

      return obj


  class LogMessageQueue

    constructor: ->
      @messageQueue = []

    push: (logMessage) ->
      @messageQueue.push logMessage

    flush: ->
      return false unless steroids.logger.logEndpoint?

      while( logMessage = @messageQueue.pop() )
        xhr = new XMLHttpRequest()
        xhr.open "POST", steroids.logger.logEndpoint, true
        xhr.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
        xhr.send JSON.stringify(logMessage.asJSON())

      return true

    startFlushing: (every) ->
      return false if @flushingInterval?

      @flushingInterval = window.setInterval =>
        @flush()
      , every

      return true

    stopFlushing: ->
      return false unless @flushingInterval?

      window.clearInterval(@flushingInterval)
      @flushingInterval = undefined

      return true

    getLength: ->
      @messageQueue.length


  constructor: ->
    @messages = []
    @queue = new LogMessageQueue

    steroids.app.host.getURL {},
      onSuccess: (url) =>
        @logEndpoint = "#{url}/__appgyver/logger"

  log: (message) ->
    logMessage = new LogMessage(message)

    @messages.push logMessage
    @queue.push logMessage

