describe "steroids", ->

  describe "device", ->

    it "should be defined", ->
      expect( steroids.device ).toBeDefined()

    describe "ping", ->

      it "should pong", ->

        ponged = false

        steroids.device.ping {},
          onSuccess: -> ponged = true

        waitsFor -> ponged

        runs ->
          expect( ponged ).toBeTruthy()

    describe "platform", ->

      it "should be defined", ->
        expect(steroids.device.platform).toBeDefined()

      it "should get the platform name", ->

        name = null

        steroids.device.platform.getName {},
          onSuccess: (gotName) -> name = gotName

        waitsFor -> name?

        runs ->
          if navigator.userAgent.match(/(iPod|iPhone|iPad)/)
            expect( name ).toBe("ios")
          else
            expect( "you" ).toBe("fixing this test for that device you are using")

    describe "torch", ->

      it "should toggle", ->
        toggled = false

        steroids.device.torch.toggle {},
          onSuccess: -> toggled = true

        waitsFor -> toggled

        runs ->
          expect( toggled ).toBeTruthy()

      it "should turn on", ->
        turnedOn = false

        steroids.device.torch.turnOn {},
          onSuccess: -> turnedOn = true

        waitsFor -> turnedOn

        runs ->
          expect( turnedOn ).toBeTruthy()

      it "should turn off", ->
        turnedOff = false

        steroids.device.torch.turnOff {},
          onSuccess: -> turnedOff = true

        waitsFor -> turnedOff

        runs ->
          expect( turnedOff ).toBeTruthy()
