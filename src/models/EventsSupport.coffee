class EventsSupport

  constructor: (@prefixName, @validEvents) ->

  # used to generate a unique event handler id
  # that can be used to de-register the handler later
  @eventCounter = Date.now()

  #register an event handler
  on: (event, callback) ->
    # validate the event name
    unless @validEvents.indexOf(event) >= 0
      throw new Error("Invalid event name!")

    if @prefixName?
      event = @prefixName + event

    eventHandlerId = ++EventsSupport.eventCounter;

    eventListenerAdded = (params) ->
      steroids.debug
        msg: "eventListenerAdded event: #{event} params: #{params}"

    errorAddingEventListener = (error) ->
      steroids.debug
        msg: "Error on addEventListener event: #{event} error: #{error}"

    fireEventHandler = (params) ->
      event = {
        name: params.name
      }

      if params.webview?
        event.webview = new steroids.views.WebView
          location: params.webview.location
          id: params.webview.id
          uuid: params.webview.uuid

      if params.target? and params.target.webview?
        event.target = {
          webview: new steroids.views.WebView
            location: params.target.webview.location
            id: params.target.webview.id
            uuid: params.target.webview.uuid
        }

      if params.source? and params.source.webview?
        event.source = {
          webview: new steroids.views.WebView
            location: params.source.webview.location
            id: params.source.webview.id
            uuid: params.source.webview.uuid
        }

      # tab info
      if params.target? and params.target.tab?
        event.target.tab = params.target.tab

      if params.source and params.source.tab?
        event.source.tab = params.source.tab

      # drawer info
      if params.drawer?
        event.drawer = params.drawer

      callback(event);

    steroids.nativeBridge.nativeCall
      method: "addEventListener"
      parameters:
        event: event
        eventHandlerId: "#{event}_#{eventHandlerId}"
      successCallbacks: [eventListenerAdded]
      recurringCallbacks: [fireEventHandler]
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

    if @prefixName?
      event = @prefixName + event

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
