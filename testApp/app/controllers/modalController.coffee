class window.ModalController

  @testShow: () ->
    opened = () ->
      alert "opened"

    hideView = new steroids.views.WebView {
      location: "/views/modal/hide.html"
    }

    steroids.modal.show {
      view: hideView
    }, {
      onSuccess: opened
    }

  @testHide: () ->

    hided = () ->
      alert "hided"

    steroids.modal.hide {
    }, {
      onSuccess: hided
    }

