describe "Rotations", ->
  orientations = [
    "portraitUpsideDown"
    "landscapeLeft"
    "landscapeRight"
    "portrait"
  ]

  describe "screen.setAllowedRotations", ->
    it "should be a function", ->
      steroids.screen.setAllowedRotations.should.be.a "function"

  describe "screen.rotate", ->
    it "should be a function", ->
      steroids.screen.rotate.should.be.a "function"

    for orientation in orientations then do (orientation) ->
      it "should rotate to #{orientation}", (done) ->
        setTimeout ->
          steroids.screen.rotate orientation,
            onTransitionEnded: -> done()
        , 500

  describe "combined tests", ->
    it "should not rotate to unallowed orientations", (done) ->
      steroids.screen.setAllowedRotations "portrait",
        onSuccess: ->
          steroids.screen.rotate "portrait",
            onSuccess: -> done()
