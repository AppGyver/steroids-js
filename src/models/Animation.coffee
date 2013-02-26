class Animation
  @TRANSITION_REVERSION_MAPPING:
    slideFromLeft: "slideFromRight"
    slideFromRight: "slideFromLeft"
    slideFromBottom: "slideFromTop"
    slideFromTop: "slideFromBottom"
    curlUp: "curlDown"
    curlDown: "curlUp"
    fade: "fade"
    flipVerticalFromBottom: "flipVerticalFromTop"
    flipVerticalFromTop: "flipVerticalFromBottom"
    flipHorizontalFromLeft: "flipHorizontalFromRight"
    flipHorizontalFromRight: "flipHorizontalFromLeft"

  constructor: (options={}) ->
    @transition = if options.constructor.name == "String"
      options
    else
      options.transition ? "curlUp"

    throw "transition required" unless @transition?


    @reversedTransition = @.constructor.TRANSITION_REVERSION_MAPPING[@transition]

    @duration = options.duration || 0.7
    @reversedDuration = @duration

    @curve = options.curve || "easeInOut"

  perform: (options={}, callbacks={}) =>

    if window.orientation != 0 and @transition in ["slideFromRight", "slideFromLeft", "slideFromTop", "slideFromBottom"]
      callbacks.onFailure?.call()
      return

    steroids.nativeBridge.nativeCall
      method: "performTransition"
      parameters: {
        transition: @transition
        curve: options.curve || @curve
        duration: options.duration || @duration
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
