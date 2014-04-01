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
    steroids.navigationBar.show "layers"

  @testPushPop: ->
    pushed = ->
      console.log "PUSHED"

    steroids.layers.push {
      view: @createWebView()
    }, {
      onSuccess: pushed
    }

  @testPop: ->
    popped = ->
      alert "popped"

    steroids.layers.pop()

  @testPushAnimated: ->
    animation = new steroids.Animation()

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }

  @testPushHideNavBar: ->
    steroids.layers.push {
      view: @createWebView(),
      navigationBar: false
    }

  @testPushHideTabBar: ->
    steroids.layers.push {
      view: @createWebView(),
      tabBar: false
    }

  @testKeepLoading: ->
    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }

  @testKeepLoadingWithPreloaded: ->
    pushPreloadedWebViewWithKeep = =>
      steroids.layers.push {
        view: keepLoadingView
        keepLoading: true
      }

    keepLoadingView = new steroids.views.WebView "/views/layers/keepLoading.html"

    keepLoadingView.preload({}, {
      onSuccess: pushPreloadedWebViewWithKeep
    })

  @testPushAnimatedSlideFromLeftAndFade: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
    }

  @testPushAnimatedSlideFromLeftAndFadeFast: ->
    animation = new steroids.Animation
      transition: "slideFromLeft"
      reversedTransition: "fade"
      duration: 0.1

    steroids.layers.push {
      view: @createWebView(),
      animation: animation
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
    }

  @testKeepLoadingThis: ->

    removeLoading = () ->
      setTimeout ->
        steroids.view.removeLoading()
      , 2000

    keepLoadingView = new steroids.views.WebView "/views/layers/pop.html"

    steroids.layers.push {
      view: keepLoadingView
      keepLoading: true
    }, {
      onSuccess: removeLoading
    }

  @testReplace: ->
    view = new steroids.views.WebView "/views/layers/index.html"
    view.preload {},
      onSuccess: =>
        steroids.layers.replace view

  @testReplaceToRoot: ->
    view = new steroids.views.WebView {
      location: "/views/layers/index.html"
      id: "http://localhost/views/steroids/index.html"
    }

    steroids.layers.replace view

  @testInvalidLayerEvents: ->
    try
      steroids.layers.on 'invalidEventName', (event) ->
        alert "should never be invoked"
    catch error
      alert "steroids.layers.on callend with an invalid event name! error: #{error}"

  @didChangeHandlers = []
  @willChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.layers.on 'willchange', (event) ->
      alert "willchange event -> eventName: #{event.name} targetWebView: #{event.targetWebView} sourceWebView: #{event.sourceWebView}"

    @willChangeHandlers.push eventHandler

    alert "event listener added"

  @testdidchangeEvent: ->
    eventHandler = steroids.layers.on 'didchange', (event) ->
      alert "didchange event -> eventName: #{event.name} targetWebView: #{event.targetWebView} sourceWebView: #{event.sourceWebView}"

    @didChangeHandlers.push eventHandler

    alert "event listener added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.layers.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.layers.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    alert "event handlers removed"

  @testRemovedidchangeEvents: ->
    steroids.layers.off 'didchange'

    alert "didchange events handlers removed"

  @testRemovewillchangeEvents: ->
    steroids.layers.off 'willchange'

    alert "willchange events handlers removed"

