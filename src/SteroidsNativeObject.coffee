class SteroidsNativeObject

  # from parent class
  emit: ->

  on: ->

  off: ->


  didHappen: (options) ->
    callback.call(@, options) for callback in options.successCallbacks

  didFail: (options)->
    callback.call(@, options) for callback in options.failureCallbacks

  attributeSetterOnSteroids: (options)->

    steroids.apiCall method: options.method
                     parameters: options.options
                     context: options.context||@context
                     callbacks:
                       recurring: () => didHappen(options)
                       success: () => didHappen(options)
                       failure: () => didFail(options)
