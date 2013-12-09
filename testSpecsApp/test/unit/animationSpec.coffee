describe "steroids", ->

  describe "Animation", ->

    it "should be defined", ->
      expect( steroids.Animation ).toBeDefined()

    it "should perform", ->
      animationPerformed = false

      animation = new steroids.Animation()
      animation.perform {},
        onSuccess: -> animationPerformed = true

      waitsFor -> animationPerformed

      runs ->
        expect( animationPerformed ).toBeTruthy()
