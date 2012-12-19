buster.spec.expose()

describe "Animation API", ->
  before ->
    this.timeout = 3000

  it "should exist", ->

    expect( typeof Steroids.Animation ).toBe "object"

  it "should animate slideFromLeft", (done)->

    Steroids.Animation.start {name: "slideFromLeft"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate slideFromRight", (done)->

    Steroids.Animation.start {name: "slideFromRight"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate slideFromTop", (done)->

    Steroids.Animation.start {name: "slideFromTop"},
      onSuccess: ->
        expect(true).toBe true
        done()


  it "should animate slideFromBottom", (done)->

    Steroids.Animation.start {name: "slideFromBottom"},
      onSuccess: ->
        expect(true).toBe true
        done()


  it "should animate flipVerticalFromTop", (done)->

    Steroids.Animation.start {name: "flipVerticalFromTop"},
      onSuccess: ->
        expect(true).toBe true
        done()


  it "should animate flipVerticalFromBottom", (done)->

    Steroids.Animation.start {name: "flipVerticalFromBottom"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate flipHorizontalFromLeft", (done)->

    Steroids.Animation.start {name: "flipHorizontalFromLeft"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate flipHorizontalFromRight", (done)->

    Steroids.Animation.start {name: "flipHorizontalFromRight"},
      onSuccess: ->
        expect(true).toBe true
        done()


  it "should animate fade", (done)->

    Steroids.Animation.start {name: "fade"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate curlDown", (done)->

    Steroids.Animation.start {name: "curlDown"},
      onSuccess: ->
        expect(true).toBe true
        done()

  it "should animate curlUp", (done)->

    Steroids.Animation.start {name: "curlUp"},
      onSuccess: ->
        expect(true).toBe true
        done()
