class window.WebviewController

  @testPreload: () ->

    webView = new steroids.views.WebView {
      location: "/views/webview/preload.html"
    }

    webView.preload {
    }, {
      onSuccess: () -> alert "preload call success"
      onFailure: () -> alert "failed to preload"
    }

  @testPreloadAndOpen: () ->

    andOpen = () ->
      alert "It's preloaded, now opening it."

      webView.location = null   # make sure that it has no location

      steroids.layers.push {
        layer: webView
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
