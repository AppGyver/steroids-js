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
      alert "visibility of #{window.location.href} changed, document.visibilityState: " + document.visibilityState + ", document.hidden: " + document.hidden

    document.addEventListener "visibilitychange", changed, true

    alert "added eventlistner for visibilitychange"

  @testCurrentVisibilityIsVisible: () ->

    alert document.hidden
    alert document.visibilityState

  @testPreloadInitialVisibilityIsPrerender: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/preloadThatTellsItsInitialVisbility.html"

    webView.preload()


  @testInModal: () ->
    webView = new steroids.views.WebView "/views/visibilitychange/modal.html"
    steroids.modal.show
      view: webView
