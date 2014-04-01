class EventsSupport

  constructor: (@validEvents) ->


  # used to generate a unique event handler id
  # that can be used to de-register the handler later
  @eventCounter = Date.now()

  #register an event handler
  on: (event, callback) ->
    # validate the event name
    unless @validEvents.indexOf(event) >= 0
      throw new Error("Invalid event name!")

    eventHandlerId = ++EventsSupport.eventCounter;

    eventListenerAdded = (params) ->
      steroids.debug
        msg: "eventListenerAdded event: #{event} params: #{params}"

    errorAddingEventListener = (error) ->
      steroids.debug
        msg: "Error on addEventListener event: #{event} error: #{error}"

    steroids.nativeBridge.nativeCall
      method: "addEventListener"
      parameters:
        event: event
        eventHandlerId: "#{event}_#{eventHandlerId}"
      successCallbacks: [eventListenerAdded]
      recurringCallbacks: [callback]
      failureCallbacks: [errorAddingEventListener]

    #return the eventHandlerId
    eventHandlerId

  off: (event, eventHandlerId) ->
    # validate the event name
    unless @validEvents.indexOf(event) >= 0
      throw new Error("Invalid event name!")
    # validate the eventHandlerId
    if eventHandlerId? and eventHandlerId <= 0
        throw new Error("Invalid event handler id!")

    eventListenerRemoved = (params) ->
      steroids.debug
        msg: "eventListenerRemoved eventHandlerId: #{eventHandlerId} params: #{params}"

    errorRemovingEventListener = (error) ->
      steroids.debug
        msg: "Error on removeEventListener eventHandlerId: #{eventHandlerId} error: #{error}"

    parameters = {
      event: event
    }

    if eventHandlerId?
      parameters.eventHandlerId = "#{event}_#{eventHandlerId}"

    steroids.nativeBridge.nativeCall
      method: "removeEventListener"
      parameters:parameters
      successCallbacks: [eventListenerRemoved]
      failureCallbacks: [errorRemovingEventListener]