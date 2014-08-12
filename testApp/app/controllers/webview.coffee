class window.WebviewController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
    return if window.location.href.match "noNavigationBar.html"

    steroids.view.navigationBar.show { title: "webview" }

  @addPreloadedViewMessageListener: () =>
    window.addEventListener "message", (msg) =>
      switch msg.data.commandToPreloadedView
        when "testReplaceToRoot"
          steroids.logger.log "testing replaceToRoot"
          @testReplaceToRoot()
        when "testAlert"
          navigator.notification.alert "I should not freeze the app!"

  @testReplaceToRoot: ->
    rootView = new steroids.views.WebView {
      location: "blabla"
      id: "http://localhost/views/steroids/index.html"
    }

    steroids.layers.replace(
      {
        view: rootView
      }
      {
        onSuccess: ->
          steroids.logger.log "Successfully replaced to root!"
        onFailure: (error)->
          steroids.logger.log "Could not replace to root: ", error
      }
    )

  @testOnSuccessWithOpen: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView
    }, {
      onSuccess: -> navigator.notification.alert "on success!"
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
      navigator.notification.alert "visibility of #{window.location.href} changed, document.visibilityState: " + document.visibilityState + ", document.hidden: " + document.hidden

    document.addEventListener "visibilitychange", changed, true

    navigator.notification.alert "added eventlistner for visibilitychange"

  @testPreload: () ->

    webView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    webView.preload {
    }, {
      onSuccess: -> navigator.notification.alert "preload call success"
      onFailure: (error) -> navigator.notification.alert "failed to preload: " + error.errorDescription
    }

  @testUnload: () ->
    preloadedView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    preloadedView.unload {
    }, {
      onSuccess: -> navigator.notification.alert "unload call success"
      onFailure: (error)  -> navigator.notification.alert "failed to unload: " + error.errorDescription
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
      navigator.notification.alert "It's preloaded, now opening it."

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
      onFailure: () -> navigator.notification.alert "preload failed"
    }

  @pushFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/pushedFromPreloaded.html"

    steroids.layers.push
      view: webView
    ,
      onSuccess: () -> steroids.logger.log "pushed webview from preloaded"

  @replaceFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/replacedFromPreloaded.html"

    webView.preload {}
    ,
      onSuccess: () ->
        steroids.layers.replace
          view: webView
        ,
          onSuccess: () -> steroids.logger.log "replaced webview from preloaded -> onSuccess"
          onFailure: () -> steroids.logger.log "replaced webview from preloaded -> onFailure"

  @testPreloadAndPushFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/preloadAndPush.html"

    webView.preload {}
    ,
      onSuccess: () -> steroids.logger.log "preload onSuccess"
      onFailure: () -> steroids.logger.log "preload onFailure"

  @testPopAll: ->

    steroids.layers.popAll {}, {}


  @testShowParamsWhenNone: () ->
    navigator.notification.alert JSON.stringify(steroids.view.params)

  @testParamsInFileURL: () ->
    fileURLWebView = new steroids.views.WebView "file://#{steroids.app.absolutePath}/views/webview/params.html"

    steroids.layers.push fileURLWebView

  @testDisableRotate: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0]
    }, {
      onSuccess: -> console.log "disabled rotating"
    }

  @testEnableRotate90: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [90]
    }, {
      onSuccess: -> console.log "allowed rotate to 90"
    }

  @testEnableRotateAll: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 90, 180, -90]
    }, {
      onSuccess: -> console.log "rotating to all directions"
    }

  @testEnableRotateHorizontal: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [-90, 90]
    }, {
      onSuccess: -> console.log "rotates to horizontal directions"
    }

  @testEnableRotateVertical: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 180]
    }, {
      onSuccess: -> console.log "rotates to vertical directions"
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
      onSuccess: -> navigator.notification.alert "keyboardc accesssory enabled"
    }

  @testDisableKeyboardAccessory: () ->
    steroids.view.updateKeyboard {
      accessoryBarEnabled:false
    }, {
      onSuccess: -> navigator.notification.alert "keyboardy accesssory disabled"
    }

  @testKeyboardAccessoryWithEmptyParams: () ->
    steroids.view.updateKeyboard null, {
      onSuccess: -> navigator.notification.alert "updateKeyboard called with no parameters (no change)"
    }

  @testPreloadViaArray: () ->
    preloadedView = new steroids.views.WebView
      id: "preloadedViaPreloadsArray"
      location: "notUsed"

    steroids.layers.push preloadedView

  #event tests
  @testCreatedEvent: ->
    eventHandler = steroids.view.on 'created', (event) ->
      navigator.notification.alert "created event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    navigator.notification.alert "event listener added"

  @testPreloadedEvent: ->
    eventHandler = steroids.view.on 'preloaded', (event) ->
      navigator.notification.alert "preloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    navigator.notification.alert "event listener added"

  @testUnloadedEvent: ->
    eventHandler = steroids.view.on 'unloaded', (event) ->
      navigator.notification.alert "unloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    navigator.notification.alert "event listener added"


  @testOffAllEvents: ->
    steroids.view.off 'created'
    steroids.view.off 'preloaded'
    steroids.view.off 'unloaded'

    navigator.notification.alert "all event listeners removed"
