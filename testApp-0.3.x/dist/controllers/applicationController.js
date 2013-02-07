(function() {

  document.addEventListener("deviceready", function() {
    $(".opensLayer").on("tap", function() {
      var layer;
      layer = new Steroids.Layer({
        location: this.getAttribute("data-location")
      });
      return Steroids.layers.push({
        layer: layer
      });
    });
    $(".opensModal").on("tap", function() {
      var layer;
      layer = new Steroids.Layer({
        location: this.getAttribute("data-location")
      });
      return Steroids.modal.show({
        layer: layer
      });
    });
    $(".closesModal").on("tap", function() {
      return Steroids.modal.hide();
    });
    return $(".performsTest").on("tap", function() {
      return eval("" + STEROIDS.controllerName + "." + (this.getAttribute("data-test")) + "()");
    });
  });

}).call(this);
