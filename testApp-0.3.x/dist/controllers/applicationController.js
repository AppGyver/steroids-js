(function() {

  document.addEventListener("deviceready", function() {
    $(".opensLayer").on("tap", function() {
      var layer;
      layer = new steroids.views.WebView({
        location: this.getAttribute("data-location")
      });
      return steroids.layers.push({
        layer: layer
      });
    });
    $(".opensModal").on("tap", function() {
      var layer;
      layer = new steroids.views.WebView({
        location: this.getAttribute("data-location")
      });
      return steroids.modal.show({
        layer: layer
      });
    });
    $(".closesModal").on("tap", function() {
      return steroids.modal.hide();
    });
    return $(".performsTest").on("tap", function() {
      return eval("" + STEROIDS.controllerName + "." + (this.getAttribute("data-test")) + "()");
    });
  });

}).call(this);
