class window.WebviewController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
    return if window.location.href.match "noNavigationBar.html"

    steroids.view.navigationBar.show { title: "webview" }

  @addPreloadedViewMessageListener: () =>
    window.addEventListener "message", (msg) =>
      switch msg.data.commandToPreloadedView
        when "testReplaceToRoot"
          steroids.logger.log "TEST testing replaceToRoot"
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
          steroids.logger.log "SUCCESS Successfully replaced to root!"
        onFailure: (error)->
          steroids.logger.log "FAILURE in testReplaceToRoot - Could not replace to root: ", error
      }
    )

  @testOnSuccessWithOpen: () ->
    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView
    }, {
      onSuccess: -> navigator.notification.alert "on success!"
    }

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

    webView.preload {},
    {
      onSuccess: -> steroids.logger.log "SUCCESS in preloading view for visibilitychange"
      onFailure: ->
        steroids.logger.log "FAILURE in testPreloadVisibilityChange"
        navigator.notification.alert "FAILURE in testPreloadVisibilityChange"
    }

    window.setTimeout =>
      steroids.layers.push webView
    , 500

  @testAddVisibilitychangeEvent: () ->
    changed = () ->
      steroids.logger.log "SUCCESS visibility of #{window.location.href} changed, document.visibilityState: " + document.visibilityState + ", document.hidden: " + document.hidden

    document.addEventListener "visibilitychange", changed, true

    steroids.logger.log "added eventlistner for visibilitychange"

  @testPreload: () ->

    webView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    webView.preload {
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in preload call"
      onFailure: (error) -> navigator.notification.alert "FAILURE in testPreload: " + error.errorDescription
    }

  @testUnload: () ->
    preloadedView = new steroids.views.WebView
      location: "/views/webview/preload.html"
      id: "myPreloaded"

    preloadedView.unload {
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in unload call"
      onFailure: (error)  -> navigator.notification.alert "FAILURE in testUnload: " + error.errorDescription
    }

  @testPreloadThisAndOpen: () ->
    andOpen = () =>
      steroids.layers.push thisWebView,
        onSuccess: -> steroids.logger.log "SUCCESS in preloading and pushing a view"
        onFailure: -> navigator.notification.alert "FAILURE in testPreloadThisAndOpen pushing the layer"

    thisWebView = new steroids.views.WebView "/views/webview/index.html"

    thisWebView.preload {
    }, {
      onSuccess: () -> andOpen()
      onFailure: -> "FAILURE in preloading in testPreloadThisAndOpen"
    }

  @testOpenThis: () ->
    thisWebView = new steroids.views.WebView "/views/webview/index.html"
    steroids.layers.push thisWebView

  @testPreloadAndOpen: () ->

    andOpen = () ->
      steroids.logger.log "View is preloaded, now opening it."

      webView.location = null   # make sure that it has no location

      steroids.layers.push {
        view: webView
      }, {
        onSuccess: () -> steroids.logger.log "SUCCESS pushed preloaded webview"
        onFailure: (error) -> navigator.notification.alert "FAILURE in testPreloadAndOpen - pushing the view:", error
      }

    webView = new steroids.views.WebView {
      location: "/views/webview/preloadAndOpen.html"
    }

    webView.preload {
    }, {
      onSuccess: () -> andOpen()
      onFailure: () -> navigator.notification.alert "FAILURE in preloading in testPreloadAndOpen"
    }

  @pushFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/pushedFromPreloaded.html"

    steroids.layers.push
      view: webView
    ,
      onSuccess: () -> steroids.logger.log "SUCCESS pushed webview from preloaded"
      onFailure: -> navigator.notification.alert "FAILURE in pushFromPreloaded"

  @replaceFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/replacedFromPreloaded.html"

    webView.preload {}
    ,
      onSuccess: () ->
        steroids.layers.replace
          view: webView
        ,
          onSuccess: () -> steroids.logger.log "SUCCESS in replacing webview from preloaded"
          onFailure: () -> steroids.logger.log "FAILURE in testReplaceFromPreloaded - replacing webview from preloaded"

  @testPreloadAndPushFromPreloaded: () ->
    webView = new steroids.views.WebView
      location: "/views/webview/preloadAndPush.html"

    webView.preload {}
    ,
      onSuccess: () -> steroids.logger.log "SUCCESS in preload"
      onFailure: (error) -> steroids.logger.log "FAILURE in testPreloadAndPushFromPreloaded in preload: ", error

  @testPopAll: ->
    steroids.layers.popAll {}, {}

  @testShowParamsWhenNone: () ->
    navigator.notification.alert JSON.stringify(steroids.view.params)

  @testParamsInFileURL: () ->
    fileURLWebView = new steroids.views.WebView "file://#{steroids.app.absolutePath}/views/webview/params.html"

    steroids.layers.push fileURLWebView

  @testOpenWithCurlUp: ->
    anim = new steroids.Animation("curlUp")

    webView = new steroids.views.WebView "/views/webview/noNavigationBar.html"

    steroids.layers.push {
      view: webView,
      animation: anim
    },
      onSuccess: -> steroids.logger.log "SUCCESS in opening with curl up animation"
      onFailure: (error) -> navigator.notification "FAILURE in testOpenWithCurlUp", error

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

  @testPreloadViaArray: () ->
    preloadedView = new steroids.views.WebView
      id: "preloadedViaPreloadsArray"
      location: "notUsed"

    steroids.layers.push preloadedView,
      onSuccess: -> steroids.logger.log "SUCCESS in pushing from preloads array"
      onFailure: (error) -> navigator.notification "FAILURE in testPreloadViaArray", error

  #event tests
  @testCreatedEvent: ->
    eventHandler = steroids.view.on 'created', (event) ->
      steroids.logger.log "SUCCESS created event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    steroids.logger.log "created event listener added"

  @testPreloadedEvent: ->
    eventHandler = steroids.view.on 'preloaded', (event) ->
      steroids.logger.log "SUCCESS preloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    steroids.logger.log "preload event listener added"

  @testUnloadedEvent: ->
    eventHandler = steroids.view.on 'unloaded', (event) ->
      steroids.logger.log "SUCCESS unloaded event -> eventName: #{event.name} webview.location: #{event.webview.location}"

    steroids.logger.log "unload event listener added"

  @testOffAllEvents: ->
    steroids.view.off 'created'
    steroids.view.off 'preloaded'
    steroids.view.off 'unloaded'

    steroids.logger.log "all event listeners removed"
