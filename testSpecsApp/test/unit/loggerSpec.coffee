describe "steroids", ->

  describe "logger", ->

    it "should be defined", ->
      expect( steroids.logger ).toBeDefined()

    describe "messages", ->

      it "should be defined", ->
        expect( steroids.logger.messages ).toBeDefined()

      it "should be initialized as an Array", ->
        expect( steroids.logger.messages.constructor.name ).toBe("Array")

    describe "log", ->

      it "should be defined", ->
        expect( steroids.logger.log ).toBeDefined()

      it "should log", ->
        beforeLoggingLength = steroids.logger.messages.length

        steroids.logger.log "hello"

        expect( steroids.logger.messages.length ).toBe(beforeLoggingLength+1)

    describe "logged message", ->

      beforeEach ->
        steroids.logger.log "hello world"
        @lastMessage = steroids.logger.messages.pop()

      it "should set message", ->
        expect( @lastMessage.message ).toBe("hello world")

      it "should have location from window location", ->
        expect( @lastMessage.location ).toMatch(/http:\/\/(\d+)\.(\d+)\.(\d+)\.(\d+)\:9876\/context\.html/)

      it "should set date", ->
        @logDate = new Date()

        # LOL: unix epoch neckbeards vs hipster mustaches.

        expect( @lastMessage.date.getDate() ).toBe(@logDate.getDate())
        expect( @lastMessage.date.getMonth() ).toBe(@logDate.getMonth())
        expect( @lastMessage.date.getYear() ).toBe(@logDate.getYear())

        expect( @lastMessage.date.getHours() ).toBe(@logDate.getHours())
        expect( @lastMessage.date.getMinutes() ).toBe(@logDate.getMinutes())
        expect( @lastMessage.date.getSeconds() ).toBe(@logDate.getSeconds())

