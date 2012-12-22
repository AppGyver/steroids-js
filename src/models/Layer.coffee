# Layer description
class Layer extends NativeObject
  # ### new Steroids.Layer
  #
  # Initializes a new Layer object for use with other navigation APIs
  #
  # Layer attributes:
  #   location:
  #     The document location for the new layer
  #     This attribute is required.
  #   pushAnimation:
  #     name of animation used when the layer is shown on screen
  #     This attribute is optional.
  #     Defaults to native behaviour. On iOS new layers slide in from the right edge of the original view.
  #   pushAnimationDuration:
  #     duration of animation used when the layer is shown on screen
  #     An integer or decimal number.
  #     This parameter is optional.
  #     Default value: 0.7
  #   popAnimation:
  #     name of animation used when the layer is removed from screen
  #     This attribute is optional.
  #     Defaults to native behaviour. On iOS removed layers slide out towards the right edge of the removed view.
  #   popAnimationDuration:
  #     duration of animation used when the layer is removed from screen
  #     An integer or decimal number.
  #     This attribute is optional.
  #     Default value: 0.7
  #
  # Valid values for attributes:
  #   location:
  #     Can be file URL path relative to the application directory. Example value: 'index.html'
  #     Can be a local URL. Files are served from the application directory. Example value: "http://localhost:13101/" (would serve "/index.html")
  #     Can be a remote URL. All reachable URLs are valid. Example value: "http://www.google.com"
  #   pushAnimation and popAnimation:
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
  #
  # #### Example:
  #
  # var layer = new Steroids.Layer({
  #   location: "http://google.com/"
  # });
  #
  constructor: (options)->
    @location = options.location
    @pushAnimation = options.pushAnimation if options.pushAnimation?
    @pushAnimationDuration = options.pushAnimationDuration if options.pushAnimationDuration?
    @popAnimation = options.popAnimation if options.popAnimation?
    @popAnimationDuration = options.popAnimationDuration if options.popAnimationDuration?
