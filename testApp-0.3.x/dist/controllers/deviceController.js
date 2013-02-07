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

    DeviceController.testTorchOn = function() {
      return steroids.device.torch.turnOn({}, {
        onSuccess: function() {
          return alert("turned on");
        }
      });
    };

    DeviceController.testTorchOff = function() {
      return steroids.device.torch.turnOff({}, {
        onSuccess: function() {
          return alert("turned off");
        }
      });
    };

    DeviceController.testTorchToggle = function() {
      return steroids.device.torch.toggle({}, {
        onSuccess: function() {
          return alert("toggled");
        }
      });
    };

    return DeviceController;

  })();

}).call(this);
