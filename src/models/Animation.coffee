# Animation description
class Animation extends NativeObject
  # ### Steroids.Animation.start
  #
  # Performs a native transition effect on the screen.
  #
  # Parameters:
  #   name:
  #     The transition to perform.
  #     This parameter is required.
  #   curve:
  #     The velocity distribution of the transition.
  #     This parameter is optional.
  #     Default value: easeInOut
  #   duration:
  #     The duration of the transition as an integer or decimal number.
  #     This parameter is optional.
  #     Default value: 0.7
  #
  # Valid parameter values:
  #   name:
  #     fade
  #       A transition that dissolves from one view to the next.
  #     curlUp
  #       A transition that curls a view up from the bottom.
  #     curlDown
  #       A transition that curls a view down from the top.
  #     flipVerticalFromBottom
  #       A transition that flips a view around its horizontal axis from bottom to top.
  #     flipVerticalFromTop
  #       A transition that flips a view around its horizontal axis from top to bottom.
  #     flipHorizontalFromLeft
  #       A transition that flips a view around its vertical axis from left to right.
  #     flipHorizontalFromRight
  #       A transition that flips a view around its vertical axis from right to left.
  #     slideFromLeft
  #       A transition that slides the next view in from the left edge of the original view.
  #     slideFromRight
  #       A transition that slides the next view in from the right edge of the original view.
  #     slideFromTop
  #       A transition that slides the next view in from the top edge of the original view.
  #     slideFromBottom
  #       A transition that slides the next view in from the bottom edge of the original view.
  #
  #   curve:
  #     easeInOut
  #       An ease-in ease-out curve causes the animation to begin slowly, accelerate through the middle of its duration, and then slow again before completing.
  #     easeIn
  #       An ease-in curve causes the animation to begin slowly, and then speed up as it progresses.
  #     easeOut
  #       An ease-out curve causes the animation to begin quickly, and then slow as it completes.
  #     linear
  #       A linear animation curve causes an animation to occur evenly over its duration.
  #
  # #### Examples:
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
  start: (options, callbacks={})->
    @nativeCall
      method: "performTransition"
      parameters: {
        transition: options.name
        curve: options.curve||"easeInOut"
        duration: options.duration||0.7
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
