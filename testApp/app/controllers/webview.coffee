class window.WebviewController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testOnSuccessWithOpen: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView
    }, {
      onSuccess: -> alert "on success!"
    }


  @testOpenWithoutNavigationBar: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView,
      navigationBar: false
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
      location: "myPreloaded"
    
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
      allowedRotations: []
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

  @testSetBackgroundCACCAA: ->
    steroids.view.setBackgroundColor("#CACCAA")

  @testSetBackgroundBlack: ->
    steroids.view.setBackgroundColor("#000000")

  @testSetBackgroundWhite: ->
    steroids.view.setBackgroundColor("#FFFFFF")

  @testHideBackgroundShadow: ->
    steroids.view.bounceShadow.hide()

  @testShowBackgroundShadow: ->
    steroids.view.bounceShadow.show()
