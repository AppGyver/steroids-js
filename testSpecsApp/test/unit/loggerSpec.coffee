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

      it "should have a JSON presentation", ->

        messageAsJSON = @lastMessage.asJSON()
        expect( messageAsJSON.date ).toMatch(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z/)

      it "should handle circular objects", ->
        circularObj =
          a: 'b'
        circularObj.circularRef = circularObj
        circularObj.list = [ circularObj, circularObj ]

        steroids.logger.log(circularObj)
        circularLogMessage = steroids.logger.messages.pop()
        circularMessageAsJSON = circularLogMessage.asJSON()

        expect( circularMessageAsJSON.message ).toBe('TypeError: JSON.stringify cannot serialize cyclic structures.')


    describe "queue", ->

      it "should be defined", ->
        expect( steroids.logger.queue ).toBeDefined()


      it "should add the message to the queue", ->
        beforeQueueingLength = steroids.logger.queue.getLength()

        steroids.logger.log("to be queued")

        expect( steroids.logger.queue.getLength() ).toBe(beforeQueueingLength + 1)


      describe "flush", ->

        it "should be defined", ->
          expect( steroids.logger.queue.flush ).toBeDefined()


        it "should flush", ->

          steroids.logger.log("a")
          steroids.logger.log("b")
          steroids.logger.log("c")

          waitsFor ->
            steroids.logger.queue.flush()

          runs ->
            expect( steroids.logger.queue.getLength() ).toBe(0)

        describe "autoflushing", ->

          it "should not flush", ->

            for msg in ["a","b","c"]
              steroids.logger.log(msg)

            waits(300)

            runs ->
              expect( steroids.logger.queue.getLength() ).not.toBe(0)

          it "should flush after flushing is set to interval", ->

            steroids.logger.queue.startFlushing(100)

            for msg in ["a","b","c"]
              steroids.logger.log(msg)

            waits(300)

            runs ->
              expect( steroids.logger.queue.getLength() ).toBe(0)

          it "should stop flushing", ->

            steroids.logger.queue.startFlushing(100)
            steroids.logger.queue.stopFlushing()

            for msg in ["a","b","c"]
              steroids.logger.log(msg)

            waits(300)

            runs ->
              expect( steroids.logger.queue.getLength() ).toBe(3)
