# always put everything inside PhoneGap deviceready

document.addEventListener "deviceready", ()->

  $(".opensLayer").each ->
    (new Hammer(@)).ontap = =>
      layer = new steroids.views.WebView { location: @getAttribute("data-location")  }
      steroids.layers.push layer

  $(".opensModal").each ->
    (new Hammer(@)).ontap = =>
      layer = new steroids.views.WebView { location: @getAttribute("data-location") }
      steroids.modal.show { layer: layer }

  $(".closesModal").each ->
    (new Hammer(@)).ontap = =>
      steroids.modal.hide()

  $(".performsTest").each ->
    (new Hammer(@)).ontap = =>
      eval "#{STEROIDS.controllerName}.#{@getAttribute("data-test")}()"
