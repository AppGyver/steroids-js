class window.LayersController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  # Make Navigation Bar to appear with a custom title text
  unless window.location.href.match("pop.html")
    steroids.navigationBar.show { title: "layers" }

  @createWebView: ->
    new steroids.views.WebView {
      location: "/views/layers/pop.html"
    }

  @testShowNavBar: ->
    steroids.navigationBar.show "layers!",
      onSuccess: -> steroids.logger.log "SUCCESS in showing navigation bar"
      onFailure: -> steroids.logger.log "FAILURE in testShowNavBar"

  @testPushPop: ->
    success = ->
      steroids.logger.log "SUCCESS in pushing pop.html"
    failure = ->
      steroids.logger.log "FAILURE in testPushPop"

    steroids.layers.push {
      view: @createWebView()
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testPop: ->
    success = ->
      steroids.logger.log "SUCCESS in popping the topmost layer"
    failure = ->
      steroids.logger.log "FAILURE in testPop"

    steroids.layers.pop({}, {
      onSuccess: success
      onFailure: failure
    })

  @testPushAnimated: ->
    animation = new steroids.Animation()

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS push with animation"
      onFailure: -> steroids.logger.log "FAILURE in testPushAnimated"
    }

  @testPushHideNavBar: ->
    steroids.layers.push {
      view: @createWebView(),
      navigationBar: false
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while hiding nav bar"
      onFailure: -> steroids.logger.log "FAILURE in testPushHideNavBar"
    }

  @testPushHideTabBar: ->
    steroids.layers.push {
      view: @createWebView(),
      tabBar: false
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while hiding tab bar"
      onFailure: -> steroids.logger.log "FAILURE in testPushHideTabBar"
    }

  @testKeepLoading: ->
    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer while keeping loading screen until non-preloaded view is loaded and result view removes the loading.html/png"
      onFailure: -> steroids.logger.log "FAILURE in testKeepLoading"
    }

  @testKeepLoadingWithPreloaded: ->
    pushPreloadedWebViewWithKeep = =>
      steroids.layers.push {
        view: keepLoadingView
        keepLoading: true
      }, {
        onSuccess: -> steroids.logger.log "SUCCESS in pushing preloaded web view while keeping loading screen until preloaded view removes it"
        onFailure: -> steroids.logger.log "FAILURE in testKeepLoadingWithPreloaded"
      }

    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    keepLoadingView.preload({}, {
      onSuccess: pushPreloadedWebViewWithKeep
      onFailure: -> steroids.logger.log "FAILURE in preloading view in testKeepLoadingWithPreloaded"
    })

  @testPushAnimatedSlideFromLeftAndFade: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and Fade animation"
      onFailure: -> steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFade"
    }

  @testPushAnimatedSlideFromLeftAndFadeFast: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"
      duration: 0.1

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and FadeFast animation"
      onFailure: -> steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFadeFast"
    }

  @testPushAnimatedSlideFromLeftAndFadeFastAndSlow: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"
      duration: 0.1
      reversedDuration: 2.5

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in pushing layer with slideFromLeft and FadeFastAndSlow animation"
      onFailure: -> steroids.logger.log "FAILURE in testPushAnimatedSlideFromLeftAndFadeFastAndSlow"
    }

  @testKeepLoadingThis: ->

    removeLoading = () ->
      setTimeout ( ->
        steroids.view.removeLoading()
      ), 2000

    keepLoadingView = new steroids.views.WebView "/views/layers/pop.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }, {
      onSuccess: ->
        removeLoading
        steroids.logger.log "SUCCESS in pushing layer while keeping loading.html/png on top, this view should remove loading html after timeout"
      onFailure: ->
        steroids.logger.log "FAILURE in testKeepLoadingThis"
    }

  @testReplace: ->
    view = new steroids.views.WebView "/views/layers/index.html"
    view.preload {},
      onSuccess: =>
        steroids.layers.replace(
          {
            view: view
          }, {
            onSuccess: -> 
              steroids.logger.log "SUCCESS in replacing with a preloaded layer"
            onFailure: -> 
              steroids.logger.log "FAILURE in testReplace while replacing view with preloaded layer"
          })
      onFailure: ->
        steroids.logger.log "FAILURE in testReplace while preloading view"


  @testReplaceToRoot: ->
    rootView = new steroids.views.WebView {
      location: "/views/layers/index.html"
      id: "http://localhost/views/steroids/index.html"
    }

    steroids.layers.replace(
      {
        view: rootView
      }, {
        onSuccess: ->
          steroids.logger.log "SUCCESS in replacing view to root without preload"
        onFailure: ->
          steroids.logger.log "FAILURE in testReplaceToRoot"
      }
    )

  @testReplaceViaPreloadedView: ->
    msg = {commandToPreloadedView: "testReplaceToRoot"}
    window.postMessage msg, '*'

  @testAlertViaPreloadedView: ->
    msg = {commandToPreloadedView: "testAlert"}
    window.postMessage msg, '*'

  @testInvalidLayerEvents: ->
    try
      steroids.layers.on 'invalidEventName', (event) ->
        steroids.logger.log "TEST FAILURE in testInvalidLayerEvents - was able to add event listener with invalid name"
    catch error
      steroids.logger.log "TEST SUCCESS steroids.layers.on was called with invalid layer event but this was catched. Error catched: '#{error}'"

  @didChangeHandlers = []
  @willChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.layers.on 'willchange', (event) ->
      targetId = if event.target? and event.target.webview.id?
        event.target.webview.id
      else
        ""
      sourceId = if event.source? and event.source.webview.id?
        event.source.webview.id
      else
        ""

      alert "willchange event -> eventName: #{event.name} target.webview.id: #{targetId} source.webview.id: #{sourceId}"

    @willChangeHandlers.push eventHandler

    steroids.logger.log "event listener for layers WILL CHANGE added"

  @testdidchangeEvent: ->
    eventHandler = steroids.layers.on 'didchange', (event) ->
      targetId = if event.target? and event.target.webview.id?
        event.target.webview.id
      else
        ""
      sourceId = if event.source? and event.source.webview.id?
        event.source.webview.id
      else
        ""
      alert "didchange event -> eventName: #{event.name} target.webview.id: #{targetId} source.webview.id: #{sourceId}"

    @didChangeHandlers.push eventHandler

    steroids.logger.log "event listener for layers DID CHANGE added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.layers.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.layers.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    steroids.logger.log "event handlers for layers change removed"

  @testRemovedidchangeEvents: ->
    steroids.layers.off 'didchange'

    steroids.logger.log "didchange events handlers removed"

  @testRemovewillchangeEvents: ->
    steroids.layers.off 'willchange'

    steroids.logger.log "willchange events handlers removed"

  @testAnotherLayer: ->
    success = ->
      steroids.logger.log "SUCCESS in pushing another layer"
    failure = ->
      steroids.logger.log "FAILURE in testAnotherLayer"

    steroids.layers.push {
      view: @createWebView()
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testPopAll: ->

    steroids.layers.popAll {}
    ,
      onTransitionStarted: ->
        steroids.logger.log "steroids.layers.popAll invoked, waiting for finished..."
      onTransitionEnd: ->
        steroids.logger.log "SUCCESS steroids.layers.popAll finished"

  @testReplaceNonPreloaded: ->
    view = new steroids.views.WebView "/views/layers/index.html"
    steroids.layers.replace {
        view: view
      }, {
        onSuccess: -> "SUCCESS in replacing a non-preloaded webview to the layer stack"
        onFailure: -> "FAILURE in testReplaceNonPreloaded"
      }

