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
        steroids.screen.rotate orientation,
          onTransitionEnded: -> done()
          onFailure: (error) ->
            done new Error error
        # setTimeout ->
        #   steroids.screen.rotate orientation,
        #     onTransitionEnded: -> done()
        #     onFailure: (error) ->
        #       done new Error error
        # , 1000
