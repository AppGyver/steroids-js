(function() {

  window.LayersController = (function() {

    function LayersController() {}

    LayersController.testPushPop = function() {
      var appgyver, pushed;
      pushed = function() {
        return console.log("PUSHED");
      };
      appgyver = new steroids.views.WebView({
        location: "/views/layers/pop.html"
      });
      return steroids.layers.push({
        layer: appgyver
      }, {
        onSuccess: pushed
      });
    };

    LayersController.testPop = function() {
      var popped;
      popped = function() {
        return alert("popped");
      };
      return steroids.layers.pop();
    };

    return LayersController;

  })();

}).call(this);
