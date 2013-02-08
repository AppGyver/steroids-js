(function() {
  var animate;

  animate = function(transitionName) {
    var anim;
    anim = new steroids.Animation({
      transition: transitionName
    });
    return anim.perform();
  };

  window.AnimationController = (function() {

    function AnimationController() {}

    AnimationController.testCurlUpFast = function() {
      var anim;
      anim = new steroids.Animation({
        transition: "curlUp",
        duration: 0.1
      });
      return anim.perform();
    };

    AnimationController.testCurlUp = function() {
      return animate("curlUp");
    };

    AnimationController.testCurlDown = function() {
      return animate("curlDown");
    };

    return AnimationController;

  })();

}).call(this);
