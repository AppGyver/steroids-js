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
    applyPatch = (setRequestHeader) =>
      XMLHttpRequest.prototype.setRequestHeader = (header, value) ->
        params = @ensureParams this
        @addHeader params, header, value

        if @isUploadHeader header then params.hasUploadHeaders = true

        setRequestHeader.call this, header, value

    applyPatch XMLHttpRequest.prototype.setRequestHeader

  patchOpen: () =>
    applyPatch = (open) =>
      XMLHttpRequest.prototype.open = (method, url, async, user, pass) ->
        params = @ensureParams this
        params.method = method
        params.url = url
        params.async = async
        params.user = user
        params.pass = pass

        open.call this, header, value

    applyPatch XMLHttpRequest.prototype.open

  logTime: (where) =>
    t1 = performance.now()
    console.log("[#{where}] took " + (t1 - t0) + " milliseconds.");

  onSuccess = (instance) => () ->
    @logTime 'sending payload to native API'

  onFailure = (instance) => () ->
    console.log 'onFailure'

  loadImage: (payload, done) ->
    fileReader = new FileReader();
    fileReader.onload = (evt) ->
      done fileReader.result
    fileReader.readAsBinaryString payload

  nativeSend: (payload, params) =>
    @t0 = performance.now()

    @loadImage payload, (data) =>
      @logTime 'load file contents'

      params.payloadContent = data;

      steroids.nativeBridge.nativeCall
        method: "xmlHttpRequest"
        parameters: params
        successCallbacks: [@onSuccess()]
        failureCallbacks: [@onFailure]

  #TODO:
  canUseApiForPayload: (payload) -> true

  patchReadyState: (instance) =>
    instance.__params.readyState = instance.readyState
    delete instance.readyState
    Object.defineProperty instance, 'readyState', {
      get: -> instance.__params.readyState,
      enumerable: true
    }

  patchSend: () =>
    applyPatch = (send) =>
      XMLHttpRequest.prototype.send = (payload) =>
        params = @ensureParams this
        if params.method == 'PUT' && params.hasUploadHeaders && @canUseApiForPayload(payload)
          @patchReadyState this
          this.__params.readyState = 3
          @nativeSend payload, params
        else
          send.call this, header

    applyPatch XMLHttpRequest.prototype.send

  patch: =>
    @patchSetRequestHeader()
    @patchOpen()
    @patchSend()
