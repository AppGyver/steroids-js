class Transitions

  push: (options = {}, callbacks = {}) ->
    steroids.nativeBridge.nativeCall
      method: "performTransitionPush"
      parameters: {
        navigationBar: options.navigationBar
        animation: options.animation
      }
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted]
      recurringCallbacks: [callbacks.onAnimationEnded]
      failureCallbacks: [callbacks.onFailure]

  pop: (options = {}, callbacks = {}) ->
    steroids.nativeBridge.nativeCall
      method: "performTransitionPop"
      parameters: {
        animation: options.animation
      }
      successCallbacks: [callbacks.onSuccess, callbacks.onAnimationStarted]
      recurringCallbacks: [callbacks.onAnimationEnded]
      failureCallbacks: [callbacks.onFailure]
