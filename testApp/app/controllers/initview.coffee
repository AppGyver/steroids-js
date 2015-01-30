class window.InitviewController

  document.addEventListener "deviceready", ->
    @preloadedView = new steroids.views.WebView
      id: 'pop_preloaded',
      location:"/views/layers/pop.html"

    @preloadedView.preload()

  @testTest: ->
    navigator.notification.alert "test test"

  @testDismissInitialView: ->
    myAnimation = new steroids.Animation
      transition: "flipHorizontalFromRight"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.dismiss
      animation: myAnimation
    ,
      onSuccess: (result) ->
        steroids.logger.log "SUCCESS in dismissing initial view"
      onFailure: (result) ->
        steroids.logger.log "FAILURE in testDismissInitialView"
        navigator.notification.alert "FAILURE in testDismissInitialView"

  @testResetAppToInitialView: ->
    myAnimation = new steroids.Animation
      transition: "slideFromBottom"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.show
      animation: myAnimation
    ,
      onSuccess: (result) ->
        steroids.logger.log "SUCCESS in showing initial view"
      onFailure: (result) ->
        steroids.logger.log "FAILURE in testResetAppToInitialView"
        navigator.notification.alert "FAILURE in testResetAppToInitialView"

  @testPushPreloadedView: ->
    preLoaded = new steroids.views.WebView "views/initview/pushedview.html"
    preLoaded.preload {}
    ,
      onSuccess: ->
        steroids.layers.push
          view: preLoaded
        ,
          onSuccess: () ->

          onFailure: (error) ->
            alert "failed to push view: " + error.errorDescription

      onFailure: (error) ->
        alert "failed to preload: " + error.errorDescription

  @testPushNewWebView: ->
    webview = new steroids.views.WebView "views/initview/pushedview.html"
    steroids.layers.push
      view: webview
    ,
      onSuccess: () ->

      onFailure: (error) ->
        alert "failed to push view: " + error.errorDescription

  @testPopView: ->
    steroids.layers.pop {}

  @testListenMessages: ->
    receiveMessage = (message) ->
      steroids.logger.log message

      success = ->
        steroids.logger.log "SUCCESS in pushing pop.html preloaded"
      failure = ->
        steroids.logger.log "FAILURE in pushing preloaded view"

      steroids.layers.push
        view:
          id: 'pop_preloaded'
      ,
        onSuccess: success
        onFailure: failure

    window.addEventListener "message", receiveMessage

    alert "Listening for messages and pushing layer when getting them"
