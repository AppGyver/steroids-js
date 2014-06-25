class window.DrawersController
  @leftDrawer: new steroids.views.WebView
    location: "views/drawers/leftDrawer.html"
    id: "leftDrawer"

  @rightDrawer: new steroids.views.WebView
    location: "views/drawers/rightDrawer.html"
    id: "rightDrawer"

  @center1: new steroids.views.WebView {
    location: "views/drawers/index.html"
    id: "center1"
  }

  @center2: new steroids.views.WebView {
    location: "views/drawers/index2.html"
    id: "center2"
  }

  @modal: new steroids.views.WebView {
    location: "views/modal/modalWithNavBar.html"
  }

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", =>

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "drawers" }

    # check for center 2
    #add a custom button
    if window.location.href.match("index2.html")
      rightDrawerBtn = new steroids.buttons.NavigationBarButton
      rightDrawerBtn.title = "->"
      rightDrawerBtn.onTap = =>
        steroids.drawers.show
          edge: steroids.screen.edges.RIGHT

      # add button to nav bar
      DrawersController.center2.navigationBar.update
        title: "Center 2"
        buttons:
          right: [rightDrawerBtn]

    # update the drawer with the webview and default parameters
    DrawersController.leftDrawer.preload {}, {
      onSuccess: =>
        steroids.drawers.update {
          left: DrawersController.leftDrawer
        }
    }

    DrawersController.rightDrawer.preload {}, {
      onSuccess: =>
        steroids.drawers.update {
          right: DrawersController.rightDrawer
        }
    }

    #center1 is the current view (index.html)
    DrawersController.center1.preload
      id: "center1"

    #preload center2
    DrawersController.center2.preload
      id: "center2"

  @testAddRightButton: ->
    rightDrawerBtn = new steroids.buttons.NavigationBarButton
    rightDrawerBtn.title = "==>"
    rightDrawerBtn.onTap = =>
      steroids.drawers.show
        edge: steroids.screen.edges.RIGHT

    # add button to nav bar
    steroids.navigationBar.update
      buttons:
        right: [rightDrawerBtn]

  @testShow: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.show {}, {
      onSuccess: success
    }

  @testShowLeft: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.show
      edge: steroids.screen.edges.LEFT
    ,
      onSuccess: success

  @testShowRight: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.show
      edge: steroids.screen.edges.RIGHT
    ,
      onSuccess: success



  @testShowNonPreloadedDrawerRight: ->
    success = ->
      alert "TEST FAIL managed to set non-preloaded view as drawer"
    failure = ->
      alert "TEST SUCCESS because failed to set non-preloaded view as drawer"

    newDrawer = new steroids.views.WebView("views/drawers/extraDrawer.html")

    steroids.drawers.update
      right: newDrawer
    ,
      onSuccess: success
      onFailure: failure



  @testShowNonPreloadedDrawerWithIdRight: ->
    success = ->
      alert "TEST FAIL managed to set non-preloaded view as drawer"
    failure = ->
      alert "TEST SUCCESS because failed to set non-preloaded view as drawer"

    newDrawer = new steroids.views.WebView
      location: "views/drawers/extraDrawer.html"
      id: "extraDrawer"

    steroids.drawers.update
      right: newDrawer
    ,
      onSuccess: success
      onFailure: failure



  @testShowPreloadedDrawerRight: ->
    success = ->
      alert "SUCCESS, check right drawer"
    failure = ->
      alert "FAILED"

    newDrawer = new steroids.views.WebView("views/drawers/extraDrawer.html")

    newDrawer.preload {},
    {
      onSuccess: =>
        steroids.drawers.update
          right: newDrawer
        ,
          onSuccess: success
          onFailure: failure
    }



  @testHide: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding the drawer"
    failure = -> 
      steroids.logger.log "FAILURE in testHide"

    steroids.drawers.hide {}, {
      onSuccess: success
      onFailure: failure
    }

  @testHideWithCenter1: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding the drawer and replacing center with center 1"
    failure = ->
      steroids.logger.log "FAILURE in testHideWithCenter1"

    # fullChange is set automatically to true if center param is used
    steroids.drawers.hide {
      center: DrawersController.center1
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testHideWithCenter1NonPreloaded: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding the drawer and replacing center with NON-PRELOADED center 1"
    failure = ->
      steroids.logger.log "FAILURE in testHideWithCenter1NonPreloaded"

    centerView = new steroids.views.WebView("/views/drawers/index.html")

    # fullChange is set automatically to true if center param is used
    steroids.drawers.hide {
      center: centerView
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testHideWithCenter2: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding the drawer and showing center 2"
    failure = ->
      steroids.logger.log "FAILURE in testHideWithCenter2"

    steroids.drawers.hide {
      center: DrawersController.center2
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testEnableAllGestures: ->
    success = ->
      steroids.logger.log "SUCCESS in enabling all swipe gestures"
    failure = ->
      steroids.logger.log "FAILURE in testEnableAllGestures"

    steroids.drawers.update {
      options:
        openGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView"],
        closeGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testLegacyEnableGesture: ->

    googleView = new steroids.views.WebView("http://www.google.com")
    googleView.preload {},
    {
      onSuccess: =>
        steroids.drawers.enableGesture
          view: googleView
          edge: steroids.screen.edges.LEFT
          widthOfDrawerInPixels: 200
        steroids.logger.log "SUCCESS in enabling legacy gesture"
      onFailure: =>
        steroids.logger.log "FAILURE in testLegacyEnableGesture"
    }

  @testLegacyEnableGestureShorthand: ->
    appleView = new steroids.views.WebView("http://www.apple.com")
    appleView.preload {},
    {
      onSuccess: =>
        steroids.drawers.enableGesture(appleView)
        steroids.logger.log "SUCCESS in enabling legacy gesture shorthand"
      onFailure: =>
        steroids.logger.log "FAILURE in testLegacyEnableGestureShorthand"
    }

  @testDisableGestureViaUpdate: ->
    success = ->
      steroids.logger.log "SUCCESS in disabling gestures via update"
    failure = ->
      steroids.logger.log "FAILURE in testDisableGestureViaUpdate"

    steroids.drawers.update {
      options:
        #both ways are valid
        openGestures: ["None"],
        #empty array is also valid
        closeGestures: []
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testLegacyDisableGesture: ->
    success = ->
      steroids.logger.log "SUCCESS"
    failure = ->
      steroids.logger.log "FAILURE"

    steroids.drawers.disableGesture
      onSuccess: success

  @testUpdateWithWidthOfLayerInPixels: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        widthOfLayerInPixels: 200
    }, {
      onSuccess: success
    }

  @testDiffSizes: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        #reset, since this overrides the widthOfDrawerInPixels values
        widthOfLayerInPixels: 0
      left:
        widthOfDrawerInPixels: 200
      right:
        widthOfDrawerInPixels: 75
    }, {
      onSuccess: success
    }

  @testDefaultSizes: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        widthOfLayerInPixels: 0,
        stretchDrawer: false
      left:
        widthOfDrawerInPixels: 280
      right:
        widthOfDrawerInPixels: 280 
    }, {
      onSuccess: success
    }

  @testHideShadow: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        showShadow: false
    }, {
      onSuccess: success
    }

  @testShowShadow: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        showShadow: true
    }, {
      onSuccess: success
    }

  @testStretchDrawer: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options: {
        widthOfLayerInPixels: 0,
        stretchDrawer: true
      }
      left:
        widthOfDrawerInPixels: 150
      right:
        widthOfDrawerInPixels: 150 
    }, {
      onSuccess: success
    }

  @testUpdateWithParallax: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update
      options:
        animation: new steroids.Animation
          transition: "parallax"
          duration: 0.9
          parallaxFactor: 2.1
    ,
      onSuccess: success

  @testUpdateWithSlideAndScale: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        animation: new steroids.Animation
          transition: "slideAndScale"
          duration: 0.5
    }, {
      onSuccess: success
    }

  @testUpdateWithSwingingDoor: ->
    success = ->
      steroids.logger.log "SUCCESS"

    steroids.drawers.update {
      options:
        animation: new steroids.Animation
          transition: "swingingDoor"
          duration: 0.5
    }, {
      onSuccess: success
    }

  @testReplaceLayers: ->
    steroids.layers.replace(
      {
        view: DrawersController.center2
      }
      {
        onSuccess: ->
          steroids.logger.log "Replaced!"
        onFailure: ->
          steroids.logger.log "Could not replace."
      }
    )

  @testShowModal: ->

    steroids.modal.show(
      {
        view: DrawersController.modal
      }
      {
        onSuccess: ->
          steroids.logger.log "Modal shown!"
        onFailure: ->
          steroids.logger.log "Could not show modal!"
      }
    )

  #event tests

  @testWillShowChangeEvent: ->
    eventHandler = steroids.drawers.on 'willshow', (event) ->
      alert "willshow event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    alert "event listener added"

  @testDidShowChangeEvent: ->
    eventHandler = steroids.drawers.on 'didshow', (event) ->
      alert "didshow event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    alert "event listener added"

  @testWillCloseChangeEvent: ->
    eventHandler = steroids.drawers.on 'willclose', (event) ->
      alert "willclose event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    alert "event listener added"

  @testDidCloseChangeEvent: ->
    eventHandler = steroids.drawers.on 'didclose', (event) ->
      alert "didclose event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    alert "event listener added"

  @testRemoveShowEvents: ->
    steroids.drawers.off 'willshow'
    steroids.drawers.off 'didshow'

    alert "show events handlers removed"

  @testRemoveCloseEvents: ->
    steroids.drawers.off 'willclose'
    steroids.drawers.off 'didclose'

    alert "close events handlers removed"

  @testTryToReusePreloadedAsModal: ->
    success = ->
      alert "should not have sucessed :-("

    fail = ->
      alert "could not open the modal !"

    steroids.modal.show
      view: DrawersController.leftDrawer
    ,
      onSuccess: success
      onFailure: fail

  @testPushLayer: ->
    popView = new steroids.views.WebView("/views/layers/pop.html")

    steroids.layers.push(
      {
        view: popView
      }
      {
        onSuccess: -> alert "Successfully pushed!"
        onFailure: -> alert "Could not push."
      }
    )

