class window.DrawersController
  @webView: new steroids.views.WebView {
    location: "/views/drawers/drawer.html"
  }

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", =>

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "drawers" }

    DrawersController.webView.preload()

  @testShow: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.show {
      view: @webView
    }, {
      onSuccess: success
    }

  @testHide: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.hide {}, {
      onSuccess: success
    }

  @testEnableGesture: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.enableGesture {
      view: @webView
    }, {
      onSuccess: success
    }

  @testDisableGesture: ->
    success = ->
      console.log "SUCCESS"

    steroids.drawers.disableGesture {}, {
      onSuccess: success
    }
  
  @testEnableGestureWithFullParams: ->
    success = ->
      console.log "SUCCESS"
    
    steroids.drawers.enableGesture {
      view: @webView,
      closeMode: "QuickClose",
      showShadow: false,
      openGestures: ["PanBezelCenterView"],
      closeGestures: ["PanCenterView", "PanDrawerView"],
      strechDrawer: false,
      centerViewInteractionMode: "NavBar"
    }, {
      onSuccess: success
    }
  
  @testShowWithFullParams: ->
    success = ->
      console.log "SUCCESS"
  
    steroids.drawers.show {
      view: @webView,
      closeMode: "FullChange",
      showShadow: true,
      openGestures: ["PanCenterView"],
      closeGestures: ["PanCenterView", "PanDrawerView"],
      strechDrawer: true,
      centerViewInteractionMode: "Full"
    }, {
      onSuccess: success
    }
