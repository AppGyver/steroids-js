(function() {

  window.LayersController = (function() {

    function LayersController() {}

    LayersController.testPushPop = function() {
      var popView, pushed;
      pushed = function() {
        return console.log("PUSHED");
      };
      popView = new steroids.views.WebView({
        location: "/views/layers/pop.html"
      });
      return steroids.layers.push({
        layer: popView
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
