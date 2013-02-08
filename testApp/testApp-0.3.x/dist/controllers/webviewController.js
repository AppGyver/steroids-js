(function() {

  window.WebviewController = (function() {

    function WebviewController() {}

    WebviewController.testPreload = function() {
      return alert("yep");
    };

    return WebviewController;

  })();

}).call(this);
