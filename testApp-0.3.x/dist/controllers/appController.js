(function() {

  window.AppController = (function() {

    function AppController() {}

    AppController.path = function() {};

    AppController.testPath = function() {
      return alert(Steroids.app.path);
    };

    return AppController;

  })();

}).call(this);
