(function() {

  window.AnalyticsController = (function() {

    function AnalyticsController() {}

    AnalyticsController.testRecordEvent = function() {
      return steroids.device.ping({
        event: {
          hello: "world"
        }
      }, {
        onSuccess: function() {
          return alert("recorded");
        }
      });
    };

    return AnalyticsController;

  })();

}).call(this);
