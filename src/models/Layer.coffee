class Layer extends NativeObject
  constructor: (options)->
    @location = options.location
    @pushAnimation = options.pushAnimation if options.pushAnimation?
    @pushAnimationDuration = options.pushAnimationDuration if options.pushAnimationDuration?
    @popAnimation = options.popAnimation if options.popAnimation?
    @popAnimationDuration = options.popAnimationDuration if options.popAnimationDuration?
