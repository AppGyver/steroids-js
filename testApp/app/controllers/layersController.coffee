class window.LayersController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "layers" }

  @createWebView: ->
    new steroids.views.WebView {
      location: "/views/layers/pop.html"
    }

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
