debug = switch
  when localStorage.debug? and (localStorage.debug || "").indexOf("steroids") isnt -1
    (args...) ->
      console.log "WebBridge: ", args...
  else
    ->
      # Swallow debug messages

class WebBridge extends Bridge

  constructor: ()->
    window.AG_SCREEN_ID = 0
    window.AG_LAYER_ID = 0
    window.AG_VIEW_ID = 0
    @registerForClientRefresh()
    @

  @isUsable: ()->
    return navigator.userAgent.indexOf("AppGyverSteroids") == -1

  registerForClientRefresh: ->
    # Don't poll for refresh if we're not in localhost (e.g. Composer2 web app).
    return if window.location.hostname isnt "localhost"

    refresh =
      id: null
      timestamp: (new Date()).getTime()

    if window.EventSource?
      source = new EventSource("http://localhost:4567/refresh_client_events?#{refresh.timestamp}")
      source.addEventListener "refresh", (e)->
        window.location.reload() if e.data == "true"
      , false

      source.addEventListener "open", (e)->
        debug "Monitoring updates from steroids npm."
      , false

      source.addEventListener "error", (e)->
        if e.readyState == EventSource.CLOSED
          debug "No longer monitoring updates from steroids npm."
    else
      pollForRefresh = ()->
        xhr = new XMLHttpRequest()
        xhr.onload = ()->
          window.location.reload() if @readyState is 4 and @status is 200 and @responseText is "true"

        xhr.open("GET", "http://localhost:4567/refresh_client?#{refresh.timestamp}")
        xhr.send()

      refresh.id = setInterval pollForRefresh, 1000

  sendMessageToNative:(messageString)->
    message = JSON.parse(messageString)

    debug message

    failed = false

    successOptions = {}
    failureOptions = {}

    switch message.method
      when "ping"
        successOptions.message = "PONG"
      when "openLayer"
        window.open message.parameters.url, "_blank"
      when "openURL"
        window.open message.parameters.url, "_blank"
      when "openModal"
        modal = document.createElement "iframe"
        modal.src = message.parameters.url
        modal.width = "100%"
        modal.height = "100%"
        modal.style.position = "absolute"
        modal.style.top = "10px"
        modal.style.left = "10px"
        modal.className = "steroidsModal"

        document.body.appendChild modal

        closeButton = document.createElement "button"
        closeButton.style.position = "absolute"
        closeButton.style.top = "0px"
        closeButton.style.left = "0px"
        closeButton.textContent = "CLOSE MODAL"

        closeButton.onclick = () =>
          modal.parentNode.removeChild(modal)
          closeButton.parentNode.removeChild(closeButton)

        document.body.appendChild closeButton

      else
        debug "unsupported API method: #{message.method}"
        failed = true


    if failed
      #@callbacks[message.callbacks.failure].call(@)
    else
      @callbacks[message.callbacks.success].call(@, successOptions)
