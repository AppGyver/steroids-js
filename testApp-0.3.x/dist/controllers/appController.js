(function() {

  window.AppController = (function() {

    function AppController() {}

    AppController.path = function() {};

    AppController.testPath = function() {
      return alert(steroids.app.path);
    };

    AppController.testAbsolutePath = function() {
      return alert(steroids.app.absolutePath);
    };

    return AppController;

  })();

}).call(this);
