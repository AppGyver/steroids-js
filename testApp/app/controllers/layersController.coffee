class window.LayersController
  @createWebView: ->
    new steroids.views.WebView {
      location: "/views/layers/pop.html"
    }

  @testPushPop: ->
    pushed = ->
      console.log "PUSHED"

    steroids.layers.push {
      layer: @createWebView()
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
      layer: @createWebView(),
      animation: animation
    }
