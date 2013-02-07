class window.LayersController

  @testPushPop: () ->
    pushed = () ->
      console.log "PUSHED"

    appgyver = new steroids.views.WebView {
      location: "/views/layers/pop.html"
    }

    steroids.layers.push {
      layer: appgyver
    }, {
      onSuccess: pushed
    }

  @testPop: () ->
    popped = () ->
      alert "popped"

    steroids.layers.pop()

