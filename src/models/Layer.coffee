class Layer extends NativeObject
  constructor: (options)->
    @location = options.location
    @pushAnimation = options.pushAnimation||"slideFromRight"
    @pushAnimationDuration = options.pushAnimationDuration||0.7
    @popAnimation = options.popAnimation||"slideFromLeft"
    @popAnimationDuration = options.popAnimationDuration||0.7

