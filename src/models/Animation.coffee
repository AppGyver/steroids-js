# Animation description
class Animation extends NativeObject

  constructor: (options={}) ->
    @transition = options.transition || "curlUp"
    @curve = options.curve || "easeInOut"
    @duration = options.duration || 0.7

  perform: (options={}, callbacks={}) =>
    @nativeCall
      method: "performTransition"
      parameters: {
        transition: options.transition || @transition
        curve: options.curve || @curve
        duration: options.duration || @duration
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  #
  # Steroids.Animation.start({
  #   name: "curlUp",
  #   curve: "easeInOut",
  #   duration: 0.7
  # }, { onSuccess: function() {
  #   console.log("Animation complete");
  # }, onFailure: function(e) {
  #   console.log("Animation received error: " + e);
  # }});
  #
  # Steroids.Animation.start({
  #   name: "curlDown"
  # }
  #
  # #### DEPRECATION NOTICE:
  #
  # This API will be refactored to be used as follows:
  #
  # var animation = new Steroids.Animation(options)
  # animation.start()
  #
