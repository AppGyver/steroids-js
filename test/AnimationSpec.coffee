buster.spec.expose()

describe "Animation API", ->
  before ->
    @timeout = 3000

  it "should exist", ->

    expect( typeof Steroids.animation ).toBe "object"

  it "should animate slideFromLeft", (done)->

    Steroids.animation.start {name: "slideFromLeft"},
      onSuccess: ->
        assert true
        done()

  it "should animate slideFromRight", (done)->

    Steroids.animation.start {name: "slideFromRight"},
      onSuccess: ->
        assert true
        done()

  it "should animate slideFromTop", (done)->

    Steroids.animation.start {name: "slideFromTop"},
      onSuccess: ->
        assert true
        done()


  it "should animate slideFromBottom", (done)->

    Steroids.animation.start {name: "slideFromBottom"},
      onSuccess: ->
        assert true
        done()


  it "should animate flipVerticalFromTop", (done)->

    Steroids.animation.start {name: "flipVerticalFromTop"},
      onSuccess: ->
        assert true
        done()


  it "should animate flipVerticalFromBottom", (done)->

    Steroids.animation.start {name: "flipVerticalFromBottom"},
      onSuccess: ->
        assert true
        done()

  it "should animate flipHorizontalFromLeft", (done)->

    Steroids.animation.start {name: "flipHorizontalFromLeft"},
      onSuccess: ->
        assert true
        done()

  it "should animate flipHorizontalFromRight", (done)->

    Steroids.animation.start {name: "flipHorizontalFromRight"},
      onSuccess: ->
        assert true
        done()


  it "should animate fade", (done)->

    Steroids.animation.start {name: "fade"},
      onSuccess: ->
        assert true
        done()

  it "should animate curlDown", (done)->

    Steroids.animation.start {name: "curlDown"},
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp", (done)->

    Steroids.animation.start {name: "curlUp"},
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp fast", (done)->

    Steroids.animation.start {name: "curlUp", duration: 0.1 },
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp with curve easeInOut", (done)->

    Steroids.animation.start {name: "curlUp", duration: 1, curve: "easeInOut" },
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp with curve easeIn", (done)->

    Steroids.animation.start {name: "curlUp", duration: 1, curve: "easeIn" },
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp with curve easeOut", (done)->

    Steroids.animation.start {name: "curlUp", duration: 1, curve: "easeOut" },
      onSuccess: ->
        assert true
        done()

  it "should animate curlUp with curve linear", (done)->

    Steroids.animation.start {name: "curlUp", duration: 1, curve: "linear" },
      onSuccess: ->
        assert true
        done()
