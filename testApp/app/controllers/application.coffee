
$(document).ready ->

  $(".opensLayer").on "click", (e) ->
    # return if !window.chrome && e.gesture.srcEvent.type == "mousedown"
    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }
    steroids.layers.push layer

  $(".opensModal").on "click", (e) ->
    # return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }
    steroids.modal.show { layer: layer }


  $(".closesModal").on "click", (e) ->
    # return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    steroids.modal.hide()

  $(".performsTest").on "click", (e) ->
    # return if !window.chrome && e.gesture.srcEvent.type == "mousedown"

    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-location")}()"


