# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").click () ->

    # Create a new layer that ...

    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }

    # ... Open on top of this document and pushes to the navigation stack
    steroids.layers.push layer


  $(".opensModal").click () ->

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }

    steroids.modal.show { layer: layer }


  $(".closesModal").click "tap", () ->
    steroids.modal.hide()

  $(".performsTest").click () ->
    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"
    return false


