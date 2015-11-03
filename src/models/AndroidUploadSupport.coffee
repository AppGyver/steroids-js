class AndroidUploadSupport

  isUploadHeader: (header) ->
    header == 'X-AG-Image-Uploader' ||
      header == 'X-AG-Image-Uploader-JPG-Quality' ||
      header == 'X-AG-Image-Uploader-Scale' ||
      header == 'X-AG-Image-Uploader-Width' ||
      header == 'X-AG-Image-Uploader-Height'

  ensureParams: (instance) =>
    if ! instance.__params
      instance.__params =
        headers:{}
    instance.__params

  addHeader: (params, header, value) -> params.headers[header] = value

  patchSetRequestHeader: () =>
    getParams = @ensureParams
    addHeader = @addHeader
    isUploadHeader = @isUploadHeader
    applyPatch = (setRequestHeader) ->
      XMLHttpRequest.prototype.setRequestHeader = (header, value) ->
        params = getParams this
        addHeader params, header, value

        if isUploadHeader header then params.hasUploadHeaders = true

        setRequestHeader.call this, header, value

    applyPatch XMLHttpRequest.prototype.setRequestHeader

  patchOpen: () =>
    getParams = @ensureParams
    applyPatch = (open) ->
      XMLHttpRequest.prototype.open = (method, url, async, user, pass) ->
        params = getParams this
        params.method = method
        params.url = url
        params.async = async
        params.user = user
        params.pass = pass
        params.timeout = this.timeout
        params.withCredentials = this.withCredentials

        open.call this, method, url, async, user, pass

    applyPatch XMLHttpRequest.prototype.open

  logTime: (where) =>
    t1 = performance.now()
    console.log("[#{where}] took " + (t1 - @t0) + " milliseconds.");

  onSuccess: (instance) => () =>
    @logTime 'payload sent to the native API'

    #LOADING
    instance.__params.readyState = 3
    instance.onreadystatechange()


  onProgress: (instance) => (result) =>
    {event, size, progress} = result

    console.log "onProgress event: #{event} size: #{size} progress: #{progress}"

    if "loadend" == event
      @logTime 'upload complete by the native API'
      {status, responseText, responseHeaders} = result

      @patchStatus instance, status
      @patchResponse instance, responseText
      @patchGetAllResponseHeaders instance, responseHeaders
      @patchGetResponseHeader instance, responseHeaders

    @fireProgressEvent instance, event, progress, size, true

  fireProgressEvent: (instance, type, loaded, total, lengthComputable) =>
    fnName = "on#{type}"
    event = new ProgressEvent(type)
    event.loaded = loaded
    event.total = total
    event.lengthComputable = lengthComputable
    try
      eventFn = instance[fnName]
      if(eventFn)
        eventFn(event)

      eventFn = instance.upload[fnName]
      if(eventFn)
        eventFn(event)
    catch e
      console.log "Error invoking event: #{fnName} error: #{JSON.stringify(e)}"

    if(type == "loadend")
      #upload ended
      instance.__params.readyState = 4
      instance.onreadystatechange()

  onFailure: (instance) => (error) =>
    console.log "onFailure error: #{JSON.stringify(error)}"
    @patchError instance, error
    @fireProgressEvent instance, "error", 0, 0, true

  loadImage: (payload, done) ->
    fileReader = new FileReader();
    fileReader.onloadend = (evt) ->
      if fileReader.error
        throw fileReader.error
      done btoa(fileReader.result)
    fileReader.readAsBinaryString payload

  nativeSend: (instance, payload, params) =>
    @t0 = performance.now()
    @loadImage payload, (data) =>
      @logTime 'load file contents into base64 string'

      params.payloadContent = data;
      params.fileName = payload.name

      steroids.nativeBridge.nativeCall
        method: "xmlHttpRequest"
        parameters: params
        successCallbacks: [@onSuccess(instance)]
        failureCallbacks: [@onFailure(instance)]
        recurringCallbacks: [@onProgress(instance)]

  canUseApiForPayload: (payload) ->
    extension = payload.name.toLowerCase().substring payload.name.lastIndexOf('.') + 1
    isImage = "jpg" == extension ||
                "jpeg" == extension ||
                "png" == extension ||
                "ico" == extension
    #24mb is the size limit to go through the API
    belowMaxSize = payload.size <= (1000 * 1000 * 24)
    console.log "size of payload: #{payload.size} bytes - #{(payload.size / 1000 / 1000)} mbs"
    return isImage && belowMaxSize

  patchGetAllResponseHeaders: (instance, headers) ->
    instance.getAllResponseHeaders = () ->
      str = ""
      for name, value in headers
        str += "#{name}: #{value}"
      return str

  patchGetResponseHeader: (instance, headers) ->
    instance.getResponseHeader = (name) -> headers[name]

  patchError: (instance, error) =>
    delete instance.error
    Object.defineProperty instance, 'error', {
      get: -> error
      enumerable: true
    }

  patchStatus: (instance, status) =>
    delete instance.status
    Object.defineProperty instance, 'status', {
      get: -> status
      enumerable: true
    }

  patchResponse: (instance, responseText) =>
    delete instance.responseText
    delete instance.response
    Object.defineProperty instance, 'responseText', {
      get: -> responseText
      enumerable: true
    }
    Object.defineProperty instance, 'response', {
      get: -> responseText
      enumerable: true
    }

  patchReadyState: (instance) =>
    instance.__params.readyState = instance.readyState
    delete instance.readyState
    Object.defineProperty instance, 'readyState', {
      get: -> instance.__params.readyState
      enumerable: true
    }

  patchSend: () =>
    getParams = @ensureParams
    patchReadyState = @patchReadyState
    nativeSend = @nativeSend
    canUseApiForPayload = @canUseApiForPayload
    fireProgressEvent = @fireProgressEvent
    applyPatch = (send) ->
      XMLHttpRequest.prototype.send = (payload) ->
        params = getParams this
        if params.method == 'PUT' && params.hasUploadHeaders && canUseApiForPayload(payload)
          this.abort()

          patchReadyState this

          nativeSend this, payload, params

          fireProgressEvent this, "loadstart", 0, payload.size, true

          #all info received -> HEADERS_RECEIVED
          params.readyState = 2
          this.onreadystatechange()
        else
          send.call this, payload

    applyPatch XMLHttpRequest.prototype.send

  load: ->
    @patchSetRequestHeader()
    @patchOpen()
    @patchSend()
