class window.ModalController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "modal" }

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

  @testShowShorthand: () ->

    hideView = new steroids.views.WebView "/views/modal/hide.html"

    steroids.modal.show(hideView)


  @testShowPreloaded: () ->

    window.addEventListener "message", (message) =>
      steroids.modal.show(preloadedView) if message.data == "okay to show modal"


    preloadedView = new steroids.views.WebView "/views/modal/preload.html"
    preloadedView.preload()


  @testShowPreloadedKeepLoading: () ->

    preloadedNowOpenModal = () =>
      setTimeout ->
        steroids.modal.show {
          view: preloadedView
          keepLoading: true
        }
      , 1000

    preloadedView = new steroids.views.WebView "/views/modal/keepLoading.html"
    preloadedView.preload {}, {
      onSuccess: preloadedNowOpenModal
    }


  @testHide: () ->

    hided = () ->
      alert "hided"

    steroids.modal.hide {
    }, {
      onSuccess: hided
    }

