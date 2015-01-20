describe "Modal", ->

  modalView = new steroids.views.WebView "/views/helpers/modal.html"

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 750
      # to solve iOS issue of trying to push when previous push is still under way

  it "should be defined", ->
    steroids.modal.should.be.defined

  describe "show & hide", ->
    it "should present and hide a modal", (done) ->
      steroids.modal.show {
        view: modalView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }

  describe "hideAll", ->

    it "should be defined and a function", ->
      steroids.modal.hideAll.should.be.defined
      steroids.modal.hideAll.should.be.a.function

    it "should show 1 modal and hide it", (done) ->

      @timeout 3000

      steroids.modal.show {
        view: modalView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hideAll {},
              onSuccess: ->
                done()
              onFailure: (error) ->
                steroids.modal.hide {},
                onSuccess: ->
                  done new Error "could not hide modal with hideAll: " + error.errorDescription
                onFailure: ->
                  done new Error "could not hide modal with hideAll and failsafe hide failed too: " + error.errorDescription
          , 750
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }

    it "should show 2 modals and hide them", (done) ->

      @timeout 3500

      steroids.modal.show {
        view: modalView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.show {
              view: modalView
            }, {
              onSuccess: ->
                setTimeout ->
                  steroids.modal.hideAll {},
                    onSuccess: ->
                      done()
                    onFailure: (error) ->
                      steroids.modal.hide {},
                      onSuccess: ->
                        steroids.modal.hide {},
                        onSuccess: ->
                          done new Error "could not hide modals with hideAll: " + error.errorDescription
                        onFailure: ->
                          done new Error "could not hide modals with hideAll and failsafe hide failed too: " + error.errorDescription
                      onFailure: ->
                        done new Error "could not hide modals with hideAll and failsafe hide failed too: " + error.errorDescription
                      done new Error "could not hide modals with hideAll: " + error.errorDescription
                , 750
              onFailure: (error) ->
                steroids.modal.hide
                done new Error "could not show the second modal: " + error.errorDescription
            }
          , 750
        onFailure: (error) ->
          done new Error "could not show the first modal: " + error.errorDescription
      }

  describe "show & hide events", ->
    it "should log 1 'willshow' event when showing & hiding a modal", (done)->

      willshow = 0

      steroids.modal.on "willshow", ->
        willshow++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                willshow.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }

    it "should log 1 'willclose' event when showing & hiding a modal", (done)->

      willclose = 0

      steroids.modal.on "willclose", ->
        willclose++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                willclose.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }


    it "should log 1 'didshow' event when showing & hiding a modal", (done)->

      didshow = 0

      steroids.modal.on "didshow", ->
        didshow++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                didshow.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }


    it "should log 1 'didclose' event when showing & hiding a modal", (done)->

      didclose = 0

      steroids.modal.on "didclose", ->
        didclose++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                didclose.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not hide modal: " + error.errorDescription
          , 500
        onFailure: (error) ->
          done new Error "could not show modal: " + error.errorDescription
      }