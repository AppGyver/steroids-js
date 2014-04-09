class window.DrawersController
  @leftDrawer: new steroids.views.WebView {
    location: "/views/drawers/leftDrawer.html"
  }

  @rightDrawer: new steroids.views.WebView {
    location: "/views/drawers/rightDrawer.html"
  }

  @center1: new steroids.views.WebView {
    location: "/views/drawers/index.html"
    id: "center1"
  }

  @center2: new steroids.views.WebView {
    location: "/views/drawers/index2.html"
    id: "center2"
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

  @testShowLeft: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show
      edge: steroids.screen.edges.LEFT
    ,
      onSuccess: success

  @testShowRight: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show
      edge: steroids.screen.edges.RIGHT
    ,
      onSuccess: success

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
      center: DrawersController.center1
    }, {
      onSuccess: success
    }

  @testHideWithFullChangeCenter2: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.hide
      fullChange: true
      center: DrawersController.center2

  @testEnableAllGestures: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        openGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView"],
        closeGestures: ["PanNavBar", "PanCenterView", "PanBezelCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]
    }, {
      onSuccess: success
    }

  @testDisableGesture: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        #both ways are valid
        openGestures: ["None"],
        #empty array is also valid
        closeGestures: []
    }, {
      onSuccess: success
    }

  @testUpdateWithWidthOfLayerInPixels: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        widthOfLayerInPixels: 160
    }, {
      onSuccess: success
    }

  @testDiffSizes: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        #reset, since this overrides the widthOfDrawerInPixels values
        widthOfLayerInPixels: 0
      left:
        widthOfDrawerInPixels: 200
      right:
        widthOfDrawerInPixels: 100
    }, {
      onSuccess: success
    }

  @testHideShadow: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        showShadow: false
    }, {
      onSuccess: success
    }

  @testShowShadow: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
        showShadow: true
    }, {
      onSuccess: success
    }

  @testUpdateWithParameters: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.update
      options:
        showShadow: true
        openGestures: ["PanBezelCenterView"]
        closeGestures: ["PanCenterView", "PanDrawerView"]
        strechDrawer: true
    ,
      onSuccess: success

  @testUpdateWithParallax: ->
    success = ->
      console.log "SUCCESS"

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
      console.log "SUCCESS"

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
      console.log "SUCCESS"

    steroids.drawers.update {
      options:
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
      options:
        showShadow: true
        openGestures: ["PanCenterView"]
        closeGestures: ["PanCenterView", "PanDrawerView"]
        strechDrawer: true
        centerViewInteractionMode: "Full"
    }, {
      onSuccess: success
    }

  @testReplaceLayers: ->
    steroids.layers.replace DrawersController.center2

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


