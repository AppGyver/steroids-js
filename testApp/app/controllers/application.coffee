
$(document).ready ->

  $(".opensLayer").hammer().on "tap", (e) ->
    return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }
    steroids.layers.push layer

  $(".opensModal").hammer().on "tap", (e) ->
    return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }
    steroids.modal.show { layer: layer }


  $(".closesModal").hammer().on "tap", (e) ->
    return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    steroids.modal.hide()

  $(".performsTest").hammer().on "tap", (e) ->
    return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"


