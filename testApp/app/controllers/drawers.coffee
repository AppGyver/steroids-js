class window.DrawersController
  @leftDrawer: new steroids.views.WebView {
    location: "/views/drawers/leftDrawer.html"
  }

  @rightDrawer: new steroids.views.WebView {
    location: "/views/drawers/rightDrawer.html"
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

    steroids.drawers.update {}, {
      #both ways are valid
      openGestures: ["None"],
      #empty array is also valid
      closeGestures: []
    }

  @testUpdateWithFullParams: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      closeMode: "QuickClose"
      showShadow: false
      openGestures: ["PanBezelCenterView"]
      closeGestures: ["PanCenterView", "PanDrawerView"]
      strechDrawer: false
      centerViewInteractionMode: "NavBar"
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
        duration: 1.2
        parallaxFactor: 3.0
    }, {
      onSuccess: success
    }

  @testShowLeftWithFullParams: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show {
      edge: steroids.screen.edges.LEFT
      closeMode: "FullChange"
      showShadow: true
      openGestures: ["PanCenterView"]
      closeGestures: ["PanCenterView", "PanDrawerView"]
      strechDrawer: true
      centerViewInteractionMode: "Full"
    }, {
      onSuccess: success
    }
