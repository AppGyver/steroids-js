(function() {

  window.ModalController = (function() {

    function ModalController() {}

    ModalController.testShow = function() {
      var hideView, opened;
      opened = function() {
        return alert("opened");
      };
      hideView = new steroids.views.WebView({
        location: "/views/modal/hide.html"
      });
      return steroids.modal.show({
        layer: hideView
      }, {
        onSuccess: opened
      });
    };

    ModalController.testHide = function() {
      var hided;
      hided = function() {
        return alert("hided");
      };
      return steroids.modal.hide({}, {
        onSuccess: hided
      });
    };

    return ModalController;

  })();

}).call(this);
