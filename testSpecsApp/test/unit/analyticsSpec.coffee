
describe "steroids", ->

  describe "analytics", ->

    it "is defined", ->
      expect(steroids.analytics).toBeDefined()


    describe "track", ->

      it "is defined", ->
        expect(steroids.analytics.track).toBeDefined()

      it "tracks an empty event", ->

        analyticEventTracked = false

        steroids.analytics.track {},
          onSuccess: -> analyticEventTracked = true

        waitsFor -> analyticEventTracked

        runs ->
         expect(analyticEventTracked).toBeTruthy()