describe "Animations", ->
  transitionNames = [
    "curlUp"
    "curlDown"
    "flipVerticalFromBottom"
    "flipVerticalFromTop"
    "flipHorizontalFromLeft"
    "flipHorizontalFromRight"
    "fade"
    "slideFromLeft"
    "slideFromRight"
    "slideFromTop"
    "slideFromBottom"
  ]

  curves = [
    "easeInOut"
    "easeIn"
    "easeOut"
    "linear"
  ]

  animate = (transitionName, curve, done) ->
    anim = new steroids.Animation
      transition: transitionName
      duration: Math.random()
      curve: curve

    anim.perform {}, {
      onAnimationEnded: -> done()
    }

  it "should be defined", ->
    steroids.Animation.should.be.defined

  describe "constructor", ->
    it "should create a new Animation object", ->
      anim = new steroids.Animation()
      anim.should.be.an.instanceOf(steroids.Animation)

  describe "perform", ->
    it "should be a function", ->
      steroids.Animation.prototype.perform.should.be.a "function"

    for transition in transitionNames
      for curve in curves then do (transition, curve) ->
        it "should perform #{transition} with curve #{curve}", (done) ->
          animate transition, curve, done
