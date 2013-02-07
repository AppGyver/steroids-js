(function() {

  window.DeviceController = (function() {

    function DeviceController() {}

    DeviceController.testPing = function() {
      var gotPong;
      gotPong = function(e) {
        return alert(e.message);
      };
      return steroids.device.ping({}, {
        onSuccess: gotPong
      });
    };

    return DeviceController;

  })();

}).call(this);
