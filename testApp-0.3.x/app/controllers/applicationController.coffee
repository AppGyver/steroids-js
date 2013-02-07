# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").on "tap", () ->

    # Create a new layer that ...

    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }

    # ... Open on top of this document and pushes to the navigation stack
    steroids.layers.push layer: layer


  $(".opensModal").on "tap", () ->

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }

    steroids.modal.show { layer: layer }


  $(".closesModal").on "tap", () ->

     steroids.modal.hide()

  $(".performsTest").on "tap", () ->

    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"


