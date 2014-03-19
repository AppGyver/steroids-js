class window.ModalController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    # steroids.navigationBar.show { title: "modal" }

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

  @testShowWithNavBar: () ->
  
    modalWithNavBar = new steroids.views.WebView "/views/modal/modalWithNavBar.html"
      
    steroids.modal.show(modalWithNavBar)
  
  @testDisplayNavigationBar: () ->
    steroids.view.navigationBar.show 
      title: "Modal Title",
      animated: true
      
    rightButton = new steroids.buttons.NavigationBarButton();
    
    rightButton.title = "Right"
    
    steroids.view.navigationBar.setButtons {
      right: [rightButton]
    }, 
    {
      onSuccess: alert "Buttons set!" ;
    }
  
  @testHideNavigationBar: () ->
    steroids.view.navigationBar.hide()
    
      
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

    hidden = () ->
      alert "hidden"

    steroids.modal.hide {
    }, {
      onSuccess: hidden
    }

  @testHideDisableAnimation: () ->

    hidden = () ->
      alert "hidden without animation"

    steroids.modal.hide {
      disableAnimation: true
    }, {
      onSuccess: hidden
    }

  @testShowDisableAnimation: () ->
    opened = () ->
      alert "opened"

    hideView = new steroids.views.WebView {
      location: "/views/modal/hide.html"
    }

    steroids.modal.show {
      view: hideView
      disableAnimation: true
    }, {
      onSuccess: opened
    }


