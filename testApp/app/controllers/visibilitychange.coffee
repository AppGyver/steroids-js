class window.VisibilitychangeController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testPreloadVisibilityChange: () ->

    webView = new steroids.views.WebView "/views/visibilitychange/preloadThatSetsVisibilityChanges.html"

    webView.preload()

    window.setTimeout =>
      steroids.layers.push webView
    , 500

  @testAddVisibilitychangeEvent: () ->
    changed = () ->
      steroids.logger.log "SUCCESS visibility of #{window.location.href} changed, document.visibilityState: " + document.visibilityState + ", document.hidden: " + document.hidden

    document.addEventListener "visibilitychange", changed, true

    steroids.logger.log "added eventlistner for visibilitychange"

  @testCurrentVisibilityIsVisible: () ->

    navigator.notification.alert "hidden or no?", document.hidden
    navigator.notification.alert "visible or no?", document.visibilityState

  @testPrerenderVisibilityIsHidden: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/preloadThatTellsItsVisibilityWhenLoaded.html"

    webView.preload()


  @testInModal: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/modal.html"
    steroids.modal.show
      view: webView
