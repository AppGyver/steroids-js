class Transitions

  push: (options = {}, callbacks = {}) ->

    parameters =
      navigationBar: options.navigationBar

    if options.animation
      parameters.pushAnimation = options.animation.transition
      parameters.pushAnimationDuration = options.animation.duration
      parameters.pushAnimationCurve = options.animation.curve

    steroids.nativeBridge.nativeCall
      method: "performTransitionPush"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted]
      recurringCallbacks: [callbacks.onAnimationEnded]
      failureCallbacks: [callbacks.onFailure]

  pop: (options = {}, callbacks = {}) ->

    parameters = {}

    if options.animation
      parameters.popAnimation = options.animation.transition
      parameters.popAnimationDuration = options.animation.duration
      parameters.popAnimationCurve = options.animation.curve

    steroids.nativeBridge.nativeCall
      method: "performTransitionPop"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted]
      recurringCallbacks: [callbacks.onAnimationEnded]
      failureCallbacks: [callbacks.onFailure]

  removeStaticContainer: (options = {}, callbacks = {}) ->
    steroids.nativeBridge.nativeCall
        method: "removeStaticContainerFromLayer"
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]
