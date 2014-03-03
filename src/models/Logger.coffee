class Logger

  constructor: ->
    @messages = []

  log: (message) ->

    class LogMessage

      constructor: (@message) ->
        @location = window.location.href
        @date = new Date()

    logMessage = new LogMessage(message)

    @messages.push(logMessage)

