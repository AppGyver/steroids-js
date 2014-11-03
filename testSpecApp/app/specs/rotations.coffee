describe "Rotations", ->
  allOrientations = [
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

    for orientation in allOrientations then do (orientation) ->
      it "should rotate to #{orientation}", (done) ->
        setTimeout ->
          steroids.screen.rotate orientation,
            onTransitionEnded: -> done()
            onFailure: (error) ->
              done new Error error
        , 500

  describe "combined tests", ->
    it "should not rotate to unallowed orientations", (done) ->
      steroids.screen.setAllowedRotations "portrait",
        onSuccess: ->
          steroids.screen.rotate "portraitUpsideDown",
            onSuccess: ->
              done new Error "onSuccess callback of rotating the screen upside down when should not be able to rotate the screen!"
            onFailure: ->
              done()
        onFailure: (error) ->
          done new Error error

      steroids.screen.setAllowedRotations allOrientations
