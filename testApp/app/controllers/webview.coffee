class window.WebviewController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
    return if window.location.href.match "noNavigationBar.html"

    steroids.view.navigationBar.show { title: "webview" }


  @testOnSuccessWithOpen: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView
    }, {
      onSuccess: -> alert "on success!"
    }


  @testRotateTo: () ->
    steroids.view.rotateTo(0)

  @testRotateTo90: () ->
    steroids.view.rotateTo(90)

  @testRotateTo180: () ->
    steroids.view.rotateTo(180)

  @testRotateToNeg90: () ->
    steroids.view.rotateTo(-90)

  @testOpenWithoutNavigationBar: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView,
      navigationBar: false
    }

  @testOpenWithoutTabBar: () ->
    webView = new steroids.views.WebView "/views/webview/noTabBar.html"

    steroids.layers.push {
      view: webView,
      tabBar: false
    }

  @testPreloadVisibilityChange: () ->

    webView = new steroids.views.WebView "/views/webview/preloadThatSetsVisibilityChanges.html"

    webView.preload()

    window.setTimeout =>
      steroids.layers.push webView
    , 500

  @testAddVisibilitychangeEvent: () ->
    changed = () ->
      alert "visibility of #{window.location.href} changed, document.visibilityState: " + document.visibilityState + ", document.hidden: " + document.hidden

    document.addEventListener "visibilitychange", changed, true

    alert "added eventlistner for visibilitychange"

  @testPreload: () ->

    webView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    webView.preload {
    }, {
      onSuccess: -> alert "preload call success"
      onFailure: (error) -> alert "failed to preload: " + error.errorDescription
    }

  @testUnload: () ->
    preloadedView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    preloadedView.unload {
    }, {
      onSuccess: -> alert "unload call success"
      onFailure: (error)  -> alert "failed to unload: " + error.errorDescription
    }

  @testPreloadThisAndOpen: () ->
    andOpen = () =>
      steroids.layers.push thisWebView

    thisWebView = new steroids.views.WebView "/views/webview/index.html"

    thisWebView.preload {
    }, {
      onSuccess: () -> andOpen()
    }

  @testOpenThis: () ->
    thisWebView = new steroids.views.WebView "/views/webview/index.html"
    steroids.layers.push thisWebView

  @testPreloadAndOpen: () ->

    andOpen = () ->
      alert "It's preloaded, now opening it."

      webView.location = null   # make sure that it has no location

      steroids.layers.push {
        view: webView
      }, {
        onSuccess: () -> "pushed preloaded webview"
      }

    webView = new steroids.views.WebView {
      location: "/views/webview/preloadAndOpen.html"
    }

    webView.preload {
    }, {
      onSuccess: () -> andOpen()
      onFailure: () -> alert "preload failed"
    }

  @testPopAll: ->

    steroids.layers.popAll {}, {}


  @testShowParamsWhenNone: () ->
    alert JSON.stringify(steroids.view.params)

  @testParamsInFileURL: () ->
    fileURLWebView = new steroids.views.WebView "file://#{steroids.app.absolutePath}/views/webview/params.html"

    steroids.layers.push fileURLWebView

  @testDisableRotate: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0]
    }, {
      onSuccess: -> alert "disabled rotating"
    }

  @testEnableRotate90: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [90]
    }, {
      onSuccess: -> alert "allowed rotate to 90"
    }

  @testEnableRotateAll: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 90, 180, -90]
    }, {
      onSuccess: -> alert "rotating to all directions"
    }

  @testEnableRotateHorizontal: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [-90, 90]
    }, {
      onSuccess: -> alert "rotates to horizontal directions"
    }

  @testEnableRotateVertical: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 180]
    }, {
      onSuccess: -> alert "rotates to vertical directions"
    }

  @testOpenWithCurlUp: ->
    anim = new steroids.Animation("curlUp")

    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView,
      animation: anim
    }

  @testSetBackgroundImage: ->
    steroids.view.setBackgroundImage("/img/space-background.png")

  @testSetBackgroundImageMontain: ->
    steroids.view.setBackgroundImage("/img/montain-bg.png")
    document.body.style.backgroundColor = 'transparent';

  @testSetBackgroundCACCAA: ->
    steroids.view.setBackgroundColor("#CACCAA")

  @testSetBackgroundBlack: ->
    steroids.view.setBackgroundColor("#000000")

  @testSetBackgroundWhite: ->
    steroids.view.setBackgroundColor("#FFFFFF")

  @testDisplayLoading: ->
    steroids.view.displayLoading()
    setTimeout ->
      #auto hide the loading screen after 3 seconds
      steroids.view.removeLoading()
    , 3000

  @testEnableKeyboardAccessory: () ->
    steroids.view.updateKeyboard {
      accessoryBarEnabled:true
    }, {
      onSuccess: -> alert "keyboardc accesssory enabled"
    }

  @testDisableKeyboardAccessory: () ->
    steroids.view.updateKeyboard {
      accessoryBarEnabled:false
    }, {
      onSuccess: -> alert "keyboardy accesssory disabled"
    }

  @testKeyboardAccessoryWithEmptyParams: () ->
    steroids.view.updateKeyboard null, {
      onSuccess: -> alert "updateKeyboard called with no parameters (no change)"
    }

  @testPreloadViaArray: () ->
    preloadedView = new steroids.views.WebView
      id: "preloadedViaPreloadsArray"
      location: "notUsed"

    steroids.layers.push preloadedView

  #event tests
  @testCreatedEvent: ->
    eventHandler = steroids.view.on 'created', (event) ->
      alert "created event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    alert "event listener added"

  @testPreloadedEvent: ->
    eventHandler = steroids.view.on 'preloaded', (event) ->
      alert "preloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    alert "event listener added"

  @testUnloadedEvent: ->
    eventHandler = steroids.view.on 'unloaded', (event) ->
      alert "unloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    alert "event listener added"


  @testOffAllEvents: ->
    steroids.view.off 'created'
    steroids.view.off 'preloaded'
    steroids.view.off 'unloaded'

    alert "all event listeners removed"
