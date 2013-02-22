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
    receiveMessage = (message) =>
      if message.data == "okay to show modal"
        steroids.modal.show(preloadedView)

    window.addEventListener "message", receiveMessage


    preloadedView = new steroids.views.WebView {
      location: "/views/modal/preload.html"
    }

    preloadedView.preload()


  @testHide: () ->

    hided = () ->
      alert "hided"

    steroids.modal.hide {
    }, {
      onSuccess: hided
    }

