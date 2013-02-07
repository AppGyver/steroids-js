# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").on "tap", () ->

    # Create a new layer that ...

    layer = new Steroids.Layer { location: @getAttribute("data-location") }

    # ... Open on top of this document and pushes to the navigation stack
    Steroids.layers.push layer: layer


  $(".opensModal").on "tap", () ->

    layer = new Steroids.Layer { location: @getAttribute("data-location") }

    Steroids.modal.show { layer: layer }


  $(".closesModal").on "tap", () ->

     Steroids.modal.hide()

  $(".performsTest").on "tap", () ->

    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"


