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
    @transition = options.transition || "curlUp"
    @reversedTransition = @.constructor.TRANSITION_REVERSION_MAPPING[@transition]

    @duration = options.duration || 0.7
    @reversedDuration = @duration

    @curve = options.curve || "easeInOut"

  perform: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "performTransition"
      parameters: {
        transition: options.transition || @transition
        curve: options.curve || @curve
        duration: options.duration || @duration
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
