describe "steroids", ->

  describe "views", ->

    it "should be defined", ->
      expect( steroids.views ).toBeDefined()


    describe "WebView", ->

      it "should be defined", ->
        expect( steroids.views.WebView ).toBeDefined()

      describe "location", ->

        beforeEach ->
          @webView = new steroids.views.WebView("https://www.example.com/path?firstParam=1&secondParam=2")

        it "should have location set as string", ->
          expect( @webView.location ).toEqual("https://www.example.com/path?firstParam=1&secondParam=2")

        it "should have location set as options", ->
          anotherWebView = new steroids.views.WebView
            location: @webView.location

          expect( anotherWebView.location ).toEqual("https://www.example.com/path?firstParam=1&secondParam=2")

        describe "when relative", ->

          it "should keep the same protocol and host", ->

            pathWebView = new steroids.views.WebView("hello/world.html")
            expect( pathWebView.location ).toEqual "#{window.location.protocol}//#{window.location.host}/hello/world.html"


      describe "params", ->

        beforeEach ->
          @webView = new steroids.views.WebView("https://www.example.com/path?firstParam=1&secondParam=2")

        it "should have params parsed from URL", ->
          expect( @webView.params ).toEqual({firstParam: '1', secondParam: '2'})

