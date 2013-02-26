# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").hammer().on "tap", () ->

    layer = new steroids.views.WebView { location: @getAttribute("data-location")  }
    steroids.layers.push layer


  $(".opensModal").hammer().on "tap", () ->

    layer = new steroids.views.WebView { location: @getAttribute("data-location") }
    steroids.modal.show { layer: layer }


  $(".closesModal").hammer().on "tap", () ->

    steroids.modal.hide()

  $(".performsTest").hammer().on "tap", () ->
    eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"
    return false


