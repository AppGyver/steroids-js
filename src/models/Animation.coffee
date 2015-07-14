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
    # Drawer animations
    slide: "slide"
    slideAndScale: "slideAndScale"
    swingingDoor: "swingingDoor"
    parallax: "parallax"

  constructor: (options={}) ->
    @transition = if options.constructor.name == "String"
      options
    else
      options.transition ? "curlUp"

    throw "transition required" unless @transition?


    @reversedTransition = options.reversedTransition ? @.constructor.TRANSITION_REVERSION_MAPPING[@transition]

    @duration = options.duration ? 0.7
    @reversedDuration = options.reversedDuration ? @duration

    @curve = options.curve ? "easeInOut"
    @reversedCurve = options.reversedCurve ? "easeInOut"

    #parallax drawer animation
    @parallaxFactor = options.parallaxFactor ? 2.0

  perform: (options={}, callbacks={}) =>

    steroids.nativeBridge.nativeCall
      method: "performAnimation"
      parameters: {
        transition: @transition
        curve: options.curve || @curve
        duration: options.duration || @duration
      }
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted]
      recurringCallbacks: [callbacks.onAnimationEnded]
      failureCallbacks: [callbacks.onFailure]
