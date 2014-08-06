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
    ,
      onSuccess: ->
        steroids.logger.log "SUCCESS in adding button to navigation bar that opens right drawer"
      onFailure: ->
        steroids.logger.log "FAILURE in testAddRightButton"

  @testShow: ->
    success = ->
      steroids.logger.log "SUCCESS in showing default drawer"
    failure = ->
      steroids.logger.log "FAILURE in testShow"

    steroids.drawers.show {}, {
      onSuccess: success
      onFailure: failure
    }

  @testShowLeft: ->
    success = ->
      steroids.logger.log "SUCCESS in showing left drawer"
    failure = ->
      steroids.logger.log "FAILURE in testShowLeft"

    steroids.drawers.show
      edge: steroids.screen.edges.LEFT
    ,
      onSuccess: success
      onFailure: failure

  @testShowRight: ->
    success = ->
      steroids.logger.log "SUCCESS in showing right drawer"
    failure = ->
      steroids.logger.log "FAILURE in testShowRight"

    steroids.drawers.show
      edge: steroids.screen.edges.RIGHT
    ,
      onSuccess: success
      onFailure: failure



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
      steroids.logger.log "TEST SUCCESS because failed to set non-preloaded view as drawer"
    failure = ->
      steroids.logger.log "TEST FAIL managed to set non-preloaded view as drawer"

    newDrawer = new steroids.views.WebView
      location: "views/drawers/extraDrawer.html"
      id: "extraDrawer"

    steroids.drawers.update
      right: newDrawer
    ,
      # test should not pass
      onSuccess: failure
      onFailure: success



  @testShowPreloadedDrawerRight: ->
    success = ->
      steroids.logger.log "SUCCESS in updating preloaded view as right drawer"
    failure = ->
      steroids.logger.log "FAILED in testShowPreloadedDrawerRight"

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

  @testHideWithNonPreloadedCenter1: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding the drawer and replacing center with NON-PRELOADED center 1"
    failure = ->
      steroids.logger.log "FAILURE in testHideWithNonPreloadedCenter1"

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
      steroids.logger.log "SUCCESS in disabling gestures the legacy way"
    failure = ->
      steroids.logger.log "FAILURE in testLegacyDisableGesture"

    steroids.drawers.disableGesture
      onSuccess: success
      onFailure: failure

  @testUpdateWithWidthOfLayerInPixels: ->
    success = ->
      steroids.logger.log "SUCCESS in updating the width of the center layer"
    failure = ->
      steroids.logger.log "FAILURE in testUpdateWithWidthOfLayerInPixels"

    steroids.drawers.update {
      options:
        widthOfLayerInPixels: 200
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testDiffSizes: ->
    success = ->
      steroids.logger.log "SUCCESS in testing different sizes for drawers"
    failure = ->
      steroids.logger.log "FAILURE in testDiffSizes"

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
      onFailure: failure
    }

  @testDefaultSizes: ->
    success = ->
      steroids.logger.log "SUCCESS in returning to original sizes for drawers and center layer"
    failure = ->
      steroids.logger.log "FAILURE in testDefaultSizes"

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
      onFailure: failure
    }

  @testHideShadow: ->
    success = ->
      steroids.logger.log "SUCCESS in hiding drawer shadow"
    failure = ->
      steroids.logger.log "FAILURE in testHideShadow"

    steroids.drawers.update {
      options:
        showShadow: false
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testShowShadow: ->
    success = ->
      steroids.logger.log "SUCCESS in showing drawer shadow"
    failure = ->
      steroids.logger.log "FAILURE in testShowShadow"

    steroids.drawers.update {
      options:
        showShadow: true
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testStretchDrawer: ->
    success = ->
      steroids.logger.log "SUCCESS in enabling stretch effect for drawer"
    failure = ->
      steroids.logger.log "FAILURE in testStretchDrawer"

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
      onFailure: failure
    }

  @testUpdateWithParallax: ->
    success = ->
      steroids.logger.log "SUCCESS in changing drawer animation to parallax"
    failure = ->
      steroids.logger.log "FAILURE in testUpdateWithParallax"

    steroids.drawers.update
      options:
        animation: new steroids.Animation
          transition: "parallax"
          duration: 0.9
          parallaxFactor: 2.1
    ,
      onSuccess: success
      onFailure: failure

  @testUpdateWithSlideAndScale: ->
    success = ->
      steroids.logger.log "SUCCESS in changing drawer animation to SlideAndScale"
    failure = ->
      steroids.logger.log "FAILURE in testUpdateWithSlideAndScale"

    steroids.drawers.update {
      options:
        animation: new steroids.Animation
          transition: "slideAndScale"
          duration: 0.5
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testUpdateWithSwingingDoor: ->
    success = ->
      steroids.logger.log "SUCCESS in changing drawer animation to SwingingDoor"
    failure = ->
      steroids.logger.log "FAILURE in testUpdateWithSwingingDoor"

    steroids.drawers.update {
      options:
        animation: new steroids.Animation
          transition: "swingingDoor"
          duration: 0.5
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testReplaceLayers: ->
    steroids.layers.replace(
      {
        view: DrawersController.center2
      }
      {
        onSuccess: ->
          steroids.logger.log "SUCCESS in replacing center layer to center 2"
        onFailure: ->
          steroids.logger.log "FAILURE in testReplaceLayers - could not replace center layer"
      }
    )

  @testShowModal: ->

    steroids.modal.show(
      {
        view: DrawersController.modal
      }
      {
        onSuccess: ->
          steroids.logger.log "SUCCESS in showing modal"
        onFailure: ->
          steroids.logger.log "FAILURE in testShowModal - could not show modal"
      }
    )

  #event tests

  @testWillShowChangeEvent: ->
    eventHandler = steroids.drawers.on 'willshow', (event) ->
      alert "willshow event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    steroids.logger.log "Event listener drawer WILL SHOW added"

  @testDidShowChangeEvent: ->
    eventHandler = steroids.drawers.on 'didshow', (event) ->
      alert "didshow event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    steroids.logger.log "Event listener drawer DID SHOW added"

  @testWillCloseChangeEvent: ->
    eventHandler = steroids.drawers.on 'willclose', (event) ->
      alert "willclose event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    steroids.logger.log "Event listener drawer WILL CLOSE added"

  @testDidCloseChangeEvent: ->
    eventHandler = steroids.drawers.on 'didclose', (event) ->
      alert "didclose event -> eventName: #{event.name} drawer.edge: #{event.drawer.edge}"

    steroids.logger.log "Event listener drawer DID CLOSE added"

  @testRemoveShowEvents: ->
    steroids.drawers.off 'willshow'
    steroids.drawers.off 'didshow'

    steroids.logger.log "Drawer show event handlers removed"

  @testRemoveCloseEvents: ->
    steroids.drawers.off 'willclose'
    steroids.drawers.off 'didclose'

    steroids.logger.log "Drawer close event handlers removed"

  @testTryToReusePreloadedAsModal: ->
    success = ->
      steroids.logger.log "TEST SUCCESS was not able to open modal"

    failure = ->
      steroids.logger.log "TEST FAILURE in testTryToReusePreloadedAsModal - should not have been able to"

    steroids.modal.show
      view: DrawersController.leftDrawer
    ,
      # modal.show should fail
      onSuccess: failure
      onFailure: success

  @testPushLayer: ->
    popView = new steroids.views.WebView("/views/layers/pop.html")

    steroids.layers.push(
      {
        view: popView
      }
      {
        onSuccess: -> alert "SUCCESS pushed layer"
        onFailure: -> alert "FAILURE in testPushLayer"
      }
    )

