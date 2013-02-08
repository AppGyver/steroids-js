(function() {

  window.SteroidsController = (function() {

    function SteroidsController() {}

    SteroidsController.testSteroidsDefined = function() {
      return alert(typeof steroids !== "undefined" && steroids !== null);
    };

    return SteroidsController;

  })();

}).call(this);
