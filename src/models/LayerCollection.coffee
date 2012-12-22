# LayerCollection description
class LayerCollection extends NativeObject
  constructor: ->
    @array = []

  # ### Steroids.layers.pop
  #
  # Removes the topmost layer on screen.
  #
  # #### Example:
  #
  # Steroids.layers.pop({}, { onSuccess: function() {
  #   console.log("Layer is being popped");
  # }, onFailure: function(e) {
  #   console.log("Layer could not be popped: " + e);
  # }});
  #
  pop: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      @array.pop()

    @nativeCall
      method: "popLayer"
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
    @array.pop()

  # ### Steroids.layers.push
  #
  # Pushes a Layer class object to be shown on screen.
  #
  # Parameters:
  #   layer:
  #     Layer object to be pushed
  #
  # #### Example:
  #
  # var layer = new Steroids.Layer({
  #   location: "http://google.com/"
  # });
  #
  # Steroids.layers.push({
  #   layer: layer
  # }, { onSuccess: function() {
  #   console.log("Layer is being pushed");
  # }, onFailure: function(e) {
  #   console.log("Layer could not be pushed: "+ e);
  # }});
  #
  push: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      ()=>@array.push options.layer

    parameters =
      url: options.layer.location

    parameters.pushAnimation = options.layer.pushAnimation if options.layer.pushAnimation?
    parameters.pushAnimationDuration = options.layer.pushAnimationDuration if options.layer.pushAnimationDuration?
    parameters.popAnimation = options.layer.popAnimation if options.layer.popAnimation?
    parameters.popAnimationDuration = options.layer.popAnimationDuration if options.layer.popAnimationDuration?

    @nativeCall
      method: "openLayer"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
