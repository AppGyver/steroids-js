class TizenBridge extends Bridge

  constructor: ()->
    refresh =
      id: null
      timestamp: (new Date()).getTime()

    pollForRefresh = ()->
      xhr = new XMLHttpRequest()
      xhr.onload = ()->
        window.location.reload() if @readyState is 4 and @status is 200 and @responseText is "true"

      getURL = "http://#{location.hostname}:4567/refresh_client?#{refresh.timestamp}"

      xhr.open("GET", getURL)
      xhr.send()

      refresh.id = setTimeout pollForRefresh, 1000

    pollForRefresh()

    return @

  @isUsable: ()->
    userAgentHasTizen = navigator.userAgent.indexOf("Tizen") != -1

    return window.tizen? || userAgentHasTizen


  sendMessageToNative:(messageString)->
    message = JSON.parse(messageString)

    console.log "TizenBridge: ", message

    failed = false

    successOptions = {}
    failureOptions = {}

    switch message.method
      when "ping"
        successOptions.message = "PONG"
      when "openLayer"
        window.open(message.parameters.url)
      when "popLayer"
        window.close()
      when "openModal"
        window.open(message.parameters.url)
      when "closeModal"
        window.close()
      else
        console.log "TizenBridge: unsupported API method: #{message.method}"
        failed = true


    if failed
      #@callbacks[message.callbacks.failure].call(@)
    else
      @callbacks[message.callbacks.success].call(@, successOptions)
