class window.ModalController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    # steroids.navigationBar.show { title: "modal" }

  @testShow: () ->
    success = ->
      steroids.logger.log "SUCCESS in opening modal"
    failure = ->
      steroids.logger.log "FAILURE in testShow modal"

    hideView = new steroids.views.WebView {
      location: "/views/modal/hide.html"
    }

    steroids.modal.show {
      view: hideView
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testAllowAllOrientations: () ->
    steroids.view.setAllowedRotations
      allowedRotations: [-90, 90, 0, 180]
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in allowing all rotations"
      onFailure: -> steroids.logger.log "FAILURE in testAllowAllOrientations"

  @testAllowOnlyPortrait: () ->
    steroids.view.setAllowedRotations
      allowedRotations: [0]
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only portrait"
      onFailure: -> steroids.logger.log "FAILURE in testAllowOnlyPortrait"

  @testShowWithNavBar: () ->
    success = ->
      steroids.logger.log "SUCCESS in opening modal with navigation bar"
    failure = ->
      steroids.logger.log "FAILURE in testShowWithNavBar modal"

    hideView = new steroids.views.WebView {
      location: "/views/modal/hide.html"
    }

    steroids.modal.show {
      view: hideView
      navigationBar: true
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testOpenAnotherModal: () ->
    steroids.modal.show {
      view: new steroids.views.WebView "/views/modal/index.html"
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in opening another modal from modal"
      onFailure: -> steroids.logger.log "FAILURE in testOpenAnotherModal from modal"
    }

  @testShowModalWithNavBar: () ->
    modalWithNavBar = new steroids.views.WebView "/views/modal/modalWithNavBar.html"

    steroids.modal.show {
      view: modalWithNavBar
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in showing a modal without calling navigationBar:true in show"
      onFailure: -> steroids.logger.log "FAILURE in testShowModalWithNavBar"
    }

  @testDisplayNavigationBar: () ->
    steroids.view.navigationBar.show
      title: "Modal Title",
      animated: true

    rightButton = new steroids.buttons.NavigationBarButton();

    rightButton.title = "Right"
    rightButton.onTap = => steroids.logger.log "Event: Right button of Modal's navigation bar was touched!"

    steroids.view.navigationBar.setButtons {
      right: [rightButton]
    },
    {
      onSuccess: -> steroids.logger.log "SUCCESS in displaying navigation bar for modal"
      onFailure: -> steroids.logger.log "FAILURE in testDisplayNavigationBar modal"
    }

  @testHideNavigationBar: () ->
    steroids.view.navigationBar.hide {}, {
      onSuccess: -> steroids.logger.log "SUCCESS in hiding navigation bar of modal"
      onFailure: -> steroids.logger.log "FAILURE in testHideNavigationBar modal"
    }


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
      # causes the app to crash if closed after 2 seconds.. that is because
      #the source webview where the aler originates is no longer on memory
      #alert "hidden"

    steroids.modal.hide {
    }, {
      onSuccess: hidden
    }

  @testHideAll: () ->

    hidden = () ->
      alert "all hidden"

    steroids.modal.hideAll {
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

  @testUpdateNavBar: ->
    closeButton = new steroids.buttons.NavigationBarButton
    closeButton.title = "Close"
    closeButton.onTap = => steroids.modal.hide()

    steroids.view.navigationBar.update {
      titleImagePath: "/icons/telescope@2x.png"
      buttons: {
        right: [closeButton]
      }
    },
      onSuccess: -> alert "nav bar buttons updated"
      onFailure: -> alert "failed to update nav bar buttons"

  @testSetAppearanceToRainbow: ->
    steroids.view.navigationBar.setAppearance {
      tintColor: '#FF0000'
      titleTextColor: '#0000FF'
      buttonTintColor: '#00FF00'
      buttonTitleTextColor: '#FF7F00'
      portraitBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
      landscapeBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
    }, {
      onSuccess: -> alert "taste the rainbow"
      onFailure: -> alert "failed set nav bar appearance"
    }

  #orientation tests

  @testModalInLandscape: ->
    opened = () ->
      alert "opened in landscape"

    landscapeModal = new steroids.views.WebView "/views/modal/modalLandscape.html"

    steroids.modal.show {
      view: landscapeModal,
      allowedRotations: ["landscapeLeft", "landscapeRight"]
    }, {
      onSuccess: opened
    }

  @testModalInPortrait: ->
    opened = () ->
      alert "opened in landscape"

    landscapeModal = new steroids.views.WebView "/views/modal/modalPortrait.html"

    steroids.modal.show {
      view: landscapeModal,
      allowedRotations: ["portrait", "portraitUpsideDown"]
    }, {
      onSuccess: opened
    }

  #event tests

  @testWillShowChangeEvent: ->
    eventHandler = steroids.modal.on 'willshow', (event) ->
      alert "willshow event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    alert "event listener added"

  @testDidShowChangeEvent: ->
    eventHandler = steroids.modal.on 'didshow', (event) ->
      alert "didshow event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    alert "event listener added"

  @testWillCloseChangeEvent: ->
    eventHandler = steroids.modal.on 'willclose', (event) ->
      alert "willclose event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    alert "event listener added"

  @testDidCloseChangeEvent: ->
    eventHandler = steroids.modal.on 'didclose', (event) ->
      alert "didclose event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    alert "event listener added"

  @testRemoveShowEvents: ->
    steroids.modal.off 'willshow'
    steroids.modal.off 'didshow'

    alert "modal show events handlers removed"

  @testRemoveCloseEvents: ->
    steroids.modal.off 'willclose'
    steroids.modal.off 'didclose'

    alert "modal close events handlers removed"

  @testGetApplicationState: ->
    steroids.getApplicationState {}
    ,
      onSuccess: (appState) ->
        alert "application state received :-)"
