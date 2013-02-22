# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").on "longTap", () ->

    # Create a new layer that ...

    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }

    # ... Open on top of this document and pushes to the navigation stack
    steroids.layers.push layer


  $(".opensModal").on "longTap", () ->

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }

    steroids.modal.show { layer: layer }


  $(".closesModal").on "longTap", () ->
    steroids.modal.hide()

  $(".performsTest").on "longTap", () ->
    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"


