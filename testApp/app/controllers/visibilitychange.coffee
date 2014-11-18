class window.VisibilitychangeController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testPreloadVisibilityChange: () ->

    webView = new steroids.views.WebView "/views/visibilitychange/preloadThatSetsVisibilityChanges.html"

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
      steroids.logger.log "SUCCESS visibility of #{window.location.href} changed, document.visibilityState == " + document.visibilityState + " && document.hidden ==" + document.hidden

    document.addEventListener "visibilitychange", changed, true

    steroids.logger.log "added eventlistener for visibilitychange to #{window.location.href}"

  @testCurrentVisibilityIsVisible: () ->
    navigator.notification.alert("document.visibilityState == " + document.visibilityState + " && document.hidden == " + document.hidden);

  @testPrerenderVisibilityIsHidden: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/preloadThatTellsItsVisibilityWhenLoaded.html"

    webView.preload()


  @testInModal: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/modal.html"
    steroids.modal.show
      view: webView
