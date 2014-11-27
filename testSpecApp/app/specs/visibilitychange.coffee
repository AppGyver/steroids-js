describe "visibilitychange", ->

  @timeout 3500

  googleView = new steroids.views.WebView "http://www.google.com"


  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 750
      # to solve iOS issue of trying to push when previous push is still under way



  describe "pushing & popping on top of listening layer", ->
    it "should log two visibilitychange events", (done) ->
      visibilityChangeCount = 0

      document.addEventListener "visibilitychange", ->
        visibilityChangeCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                visibilityChangeCount.should.equal 2
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }



    it "should log one and only one 'hidden' visibilitychange", (done) ->

      hiddenCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "hidden"
          hiddenCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                hiddenCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }



    it "should log one 'visible' visibilitychange", (done) ->
      visibleCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "visible"
          visibleCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                visibleCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }



  describe "opening a modal on top of listening layer", ->
    it "should log two visibilitychange events", (done) ->
      visibilityChangeCount = 0

      document.addEventListener "visibilitychange", ->
        visibilityChangeCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                visibilityChangeCount.should.equal 2
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }



    it "should log one and only one 'hidden' visibilitychange", (done) ->

      hiddenCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "hidden"
          hiddenCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                hiddenCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }



    it "should log one 'visible' visibilitychange", (done) ->
      visibleCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "visible"
          visibleCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                visibleCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }



  describe "a different layer than the one shown listening to visibilitychange", =>

    it "should be hidden after being preloaded", (done) =>
      listenerView = new steroids.views.WebView "/views/helpers/visibilitychangelayer.html?mode=hidden"

      receiveMessage = (message) ->
        window.removeEventListener "message", receiveMessage
        message.data.text.should.equal "document.hidden == true"
        done()

      window.addEventListener "message", receiveMessage

      listenerView.preload {},
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


    it "should have visibilityState hidden after being preloaded", (done) =>
      listenerView = new steroids.views.WebView "/views/helpers/visibilitychangelayer.html?mode=visibilityState"

      receiveMessage = (message) ->
        window.removeEventListener "message", receiveMessage
        message.data.text.should.equal "document.visibilityState == hidden"
        done()

      window.addEventListener "message", receiveMessage

      listenerView.preload {},
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


    it "should fire some kind of visibilitychange on push after preload", (done) ->
      listenerView = new steroids.views.WebView {
        location: "/views/helpers/visibilitychangelayer.html",
        id: "listener1"
      }

      postMessageCount = 0

      receiveMessage = (message) ->
        postMessageCount++

      window.addEventListener "message", receiveMessage

      listenerView.preload {},
        onSuccess: ->
          setTimeout ->
            steroids.layers.push {
              view: listenerView
            }, {
              onSuccess: ->
                setTimeout ->
                  window.removeEventListener "message", receiveMessage

                  steroids.layers.pop {},
                    onSuccess: ->
                      listenerView.unload()
                      postMessageCount.should.equal 2
                      done()
                    onFailure: (error) ->
                      done new Error "could not pop view: " + error.errorDescription
                , 500
              onFailure: (error) ->
                done new Error "could not push view: " + error.errorDescription
            }
          , 500
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


    it "should fire right kind of visibilitychange on push after preload", (done) ->
      listenerView = new steroids.views.WebView {
        location: "/views/helpers/visibilitychangelayer.html",
        id: "listener2"
      }

      hiddenCount = 0
      visibleCount = 0

      receiveMessage = (message) ->
        if message.data.text is "document.hidden == false"
          hiddenCount++
        else if message.data.text is "document.visibilityState == visible"
          visibleCount++

      window.addEventListener "message", receiveMessage

      listenerView.preload {},
        onSuccess: ->
          setTimeout ->
            steroids.layers.push {
              view: listenerView
            }, {
              onSuccess: ->
                window.removeEventListener "message", receiveMessage

                setTimeout ->
                  steroids.layers.pop {},
                    onSuccess: ->
                      setTimeout ->
                        listenerView.unload()
                        hiddenCount.should.equal 1, "did not have right hidden state"
                        visibleCount.should.equal 1, "did not have right visibilityState"
                        done()
                      , 750
                    onFailure: (error) ->
                      done new Error "could not pop view: " + error.errorDescription
                , 500

              onFailure: (error) ->
                done new Error "could not push view: " + error.errorDescription
            }
          , 500
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


    it "should fire some kind of visibilitychange on pop after preload&push", (done) ->
      listenerView = new steroids.views.WebView {
        location: "/views/helpers/visibilitychangelayer.html",
        id: "listener3"
      }

      postMessageCount = 0

      receiveMessage = (message) ->
        postMessageCount++

      listenerView.preload {},
        onSuccess: ->
          steroids.layers.push {
            view: listenerView
          }, {
            onSuccess: ->
              window.addEventListener "message", receiveMessage

              setTimeout ->
                steroids.layers.pop {},
                  onSuccess: ->
                    setTimeout ->
                      window.removeEventListener "message", receiveMessage
                      listenerView.unload()
                      postMessageCount.should.equal 2
                      done()
                    , 750
                  onFailure: (error) ->
                    done new Error "could not pop view: " + error.errorDescription
              , 500

            onFailure: (error) ->
              done new Error "could not push view: " + error.errorDescription
          }
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


    it "should fire right kind of visibilitychange on pop after preload&push", (done) ->
      listenerView = new steroids.views.WebView {
        location: "/views/helpers/visibilitychangelayer.html",
        id: "listener4"
      }

      hiddenCount = 0
      visibleCount = 0

      receiveMessage = (message) ->
        if message.data.text is "document.hidden == true"
          hiddenCount++
        else if message.data.text is "document.visibilityState == hidden"
          visibleCount++

      listenerView.preload {},
        onSuccess: ->
          steroids.layers.push {
            view: listenerView
          }, {
            onSuccess: ->
              window.addEventListener "message", receiveMessage

              setTimeout ->
                steroids.layers.pop {},
                  onSuccess: ->
                    setTimeout ->
                      window.removeEventListener "message", receiveMessage
                      listenerView.unload()
                      hiddenCount.should.equal 1, "did not have right hidden state"
                      visibleCount.should.equal 1, "did not have right visibilityState"
                      done()
                    , 750
                  onFailure: (error) ->
                    done new Error "could not pop view: " + error.errorDescription
              , 500

            onFailure: (error) ->
              done new Error "could not push view: " + error.errorDescription
          }
        onFailure: (error) ->
          window.removeEventListener "message", receiveMessage
          done new Error "could not preload view: " + error.errorDescription


