document.addEventListener "deviceready", ->

  openElement = document.getElementById("openLayer")
  openFadeElement = document.getElementById("openLayerFade")
  popElement = document.getElementById("popLayer")
  openModalElement = document.getElementById("openModal")

  if openElement?
    openElement.addEventListener "touchstart", ->
      layer = new Steroids.Layer({location: "http://localhost:13101/views/layers/show.html"})
      Steroids.layers.push layer

  if openFadeElement?
    openFadeElement.addEventListener "touchstart", ->
      layer = new Steroids.Layer {
        location: "http://localhost:13101/views/layers/show.html"
        pushAnimation: "fade"
        pushAnimationDuration: 1
        popAnimation: "fade"
        popAnimationDuration: 1
      }

      Steroids.layers.push layer

  if popElement?
    popElement.addEventListener "touchstart", ->
      Steroids.layers.pop()

  if openModalElement?
    openModalElement.addEventListener "touchstart", ->

      layer = new Steroids.Layer({location: "http://www.google.com"})

      Steroids.Modal.show(layer)

      setTimeout ()->
        Steroids.Modal.hide()
      , 5000

  Steroids.navigationBar.show {title: "LAYERS"}

  Steroids.navigationBar.rightButton.show {title: "Modal"}, onRecurring: ()->
    createLayer = new Steroids.Layer {
      location:"http://www.google.com"
    }

    Steroids.Modal.show(createLayer)

    setTimeout ()->
      Steroids.Modal.hide()
    , 5000
