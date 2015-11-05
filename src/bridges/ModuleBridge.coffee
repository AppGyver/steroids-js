debug = switch
  when localStorage.debug? and (localStorage.debug || "").indexOf("steroids") isnt -1
    (args...) ->
      console.log "ModuleBridge: ", args...
  else
    ->
      # Swallow debug messages


class ModuleBridge extends Bridge

  constructor: ()->
    window.AG_SCREEN_ID = 0
    window.AG_LAYER_ID = 0
    window.AG_VIEW_ID = 0
    return @

  @isUsable: ()->
    return /gyver\.com$/.test(location.hostname)

  sendMessageToNative:(messageString)->
    message = JSON.parse(messageString)

    debug message

    failed = false

    successOptions = {}
    failureOptions = {}
    failSilentlyMethods = [
      "userFilesPath"
      "getApplicationPath"
      "getEndpointURL"
      "addEventListener"
      "broadcastJavascript"
      "getApplicationState"
    ]

    switch message.method
      when "ping"
        successOptions.message = "PONG"
      when "popLayer"
        window.history.back()
      when "openLayer"
        window.location.href = message.parameters.url
      when "openURL"
        window.open message.parameters.url, "_blank"
      when "openModal"
        #window.open message.parameters.url, "_blank"
        steroids.component.helper.openModal message.parameters.url, {}
      when "closeModal"
        steroids.component.helper.closeModal()
      else
        debug "unsupported API method: #{message.method}" unless message.method in failSilentlyMethods
        failed = true


    if failed
      #@callbacks[message.callbacks.failure].call(@)
    else
      @callbacks[message.callbacks.success].call(@, successOptions)
