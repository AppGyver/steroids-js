class window.DrawersController
  @leftDrawer: new steroids.views.WebView {
    location: "/views/drawers/leftDrawer.html"
  }

  @rightDrawer: new steroids.views.WebView {
    location: "/views/drawers/rightDrawer.html"
  }

  @center1: null

  @center2: new steroids.views.WebView {
    location: "/views/drawers/index2.html"
  }

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", =>

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "drawers" }

    # update the drawer with the webview and default parameters
    DrawersController.leftDrawer.preload {}, {
      onSuccess: =>
        steroids.drawers.update {
          leftView: DrawersController.leftDrawer
        }
    }

    DrawersController.rightDrawer.preload {}, {
      onSuccess: =>
        steroids.drawers.update {
          rightView: DrawersController.rightDrawer
        }
    }

    #center1 is the current view (index.html)
    DrawersController.center1 = steroids.view

    #preload center2
    DrawersController.center2.preload()


  @testShowLeft: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show {
      edge: steroids.screen.edges.LEFT
    }, {
      onSuccess: success
    }

  @testShowRight: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show {
      edge: steroids.screen.edges.RIGHT
    }, {
      onSuccess: success
    }

  @testHide: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.hide {}, {
      onSuccess: success
    }

  @testHideWithFullChangeCenter1: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.hide {
      fullChange: true
      centerView: DrawersController.center1
    }, {
      onSuccess: success
    }

  @testHideWithFullChangeCenter2: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.hide {
      fullChange: true
      centerView: DrawersController.center2
    }, {
      onSuccess: success
    }

  @testEnableAllGestures: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      openGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView"],
      closeGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]
    }, {
      onSuccess: success
    }

  @testDisableGesture: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      #both ways are valid
      openGestures: ["None"],
      #empty array is also valid
      closeGestures: []
    }, {
      onSuccess: success
    }

  @testUpdateWithParameters: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      closeMode: "FullChange"
      showShadow: true
      openGestures: ["PanBezelCenterView"]
      closeGestures: ["PanCenterView", "PanDrawerView"]
      strechDrawer: true
    }, {
      onSuccess: success
    }

  @testUpdateWithParallax: ->
    success = ->
      console.log "SUCCESS"

    # steroids.drawers.enableGesture {
    #  side: ['left']
    # }

    steroids.drawers.update {
      animation: new steroids.Animation
        transition: "parallax"
        duration: 0.9
        parallaxFactor: 2.1
    }, {
      onSuccess: success
    }

  @testUpdateWithSlideAndScale: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      animation: new steroids.Animation
        transition: "slideAndScale"
        duration: 0.5
    }, {
      onSuccess: success
    }

  @testUpdateWithSwingingDoor: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      animation: new steroids.Animation
        transition: "swingingDoor"
        duration: 0.5
    }, {
      onSuccess: success
    }

  @testShowLeftWithFullParams: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show {
      edge: steroids.screen.edges.LEFT
      showShadow: true
      openGestures: ["PanCenterView"]
      closeGestures: ["PanCenterView", "PanDrawerView"]
      strechDrawer: true
      centerViewInteractionMode: "Full"
    }, {
      onSuccess: success
    }
