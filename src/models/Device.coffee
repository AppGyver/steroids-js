class Device extends NativeObject
  constructor: ->

  # ###Steroids.device.ping
  #
  #   Ping the native side using given payload
  #
  # ####Example:
  #     Steroids.device.ping({data: 'BIGDATA'}, {
  #       onSuccess: function(parameters){
  #         parameters.message == 'pong' // => true
  #       }
  #     })
  ping: (options, callbacks={})->
    @nativeCall
      method: "ping"
      parameters:
        payload: options.data
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]