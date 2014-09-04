class window.ModalController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->
    @preloadedView = new steroids.views.WebView
      id: 'hide_preloaded'
      location:"/views/modal/hide.html"

    @preloadedView.preload()

  @testShow: () ->
    success = ->
      steroids.logger.log "SUCCESS in opening modal"
    failure = ->
      steroids.logger.log "FAILURE in testShow modal"
      navigator.notification.alert "FAILURE in testShow modal"

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
    steroids.screen.setAllowedRotations
      allowedRotations: ["landscapeLeft", "landscapeRight", "portrait", "portraitUpsideDown"]
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in allowing all rotations"
      onFailure: ->
        steroids.logger.log "FAILURE in testAllowAllOrientations"
        navigator.notification.alert "FAILURE in testAllowAllOrientations"

  @testAllowOnlyPortrait: () ->
    steroids.screen.setAllowedRotations
      allowedRotations: ["portrait"]
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only portrait"
      onFailure: ->
        steroids.logger.log "FAILURE in testAllowOnlyPortrait"
        navigator.notification.alert "FAILURE in testAllowOnlyPortrait"

  @testShowWithNavBar: () ->
    success = ->
      steroids.logger.log "SUCCESS in opening modal with navigation bar"
    failure = ->
      steroids.logger.log "FAILURE in testShowWithNavBar modal"
      navigator.notification.alert "FAILURE in testShowWithNavBar modal"

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
      onFailure: ->
        steroids.logger.log "FAILURE in testOpenAnotherModal from modal"
        navigator.notification.alert "FAILURE in testOpenAnotherModal from modal"
    }

  @testShowModalWithNavBar: () ->
    modalWithNavBar = new steroids.views.WebView "/views/modal/modalWithNavBar.html"

    steroids.modal.show {
      view: modalWithNavBar
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in showing a modal without calling navigationBar:true in show"
      onFailure: ->
        steroids.logger.log "FAILURE in testShowModalWithNavBar"
        navigator.notification.alert "FAILURE in testShowModalWithNavBar"
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
      onFailure: ->
        steroids.logger.log "FAILURE in testDisplayNavigationBar modal"
        navigator.notification.alert "FAILURE int testDisplayNavigationBar modal"
    }

  @testHideNavigationBar: () ->
    steroids.view.navigationBar.hide {}, {
      onSuccess: -> steroids.logger.log "SUCCESS in hiding navigation bar of modal"
      onFailure: ->
        steroids.logger.log "FAILURE in testHideNavigationBar modal"
        navigator.notification.alert "FAILURE in testHideNavigationBar modal"
    }

  @testShowPreloaded: () ->
    steroids.modal.show
      view: new steroids.views.WebView
        id: 'hide_preloaded'
        location:"/views/modal/hide.html"

  @testShowPreloadedOnce: () ->
    window.addEventListener "message", (message) =>
      steroids.modal.show(preloadedView) if message.data == "okay to show modal"

    preloadedView = new steroids.views.WebView
      location: "/views/modal/preload.html"
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
      navigator.notification.alert "SUCCESS modal hidden, n.n.alert does not crash here"

    steroids.modal.hide {
    }, {
      onSuccess: hidden
      onFailure: -> navigator.notification.alert "FAILURE in hiding modal"
    }

  @testHideAll: () ->

    hidden = () ->
      navigator.notification.alert "SUCCESS all modals hidden, n.n.alert does not crash"

    steroids.modal.hideAll {
    }, {
      onSuccess: hidden
      onFailure: -> navigator.notification.alert "FAILURE in hiding all modals"
    }

  @testHideDisableAnimation: () ->

    hidden = () ->
      navigator.notification.alert "SUCCESS hidden without animation, n.n.alert does not crash"

    steroids.modal.hide {
      disableAnimation: true
    }, {
      onSuccess: hidden
      onFailure: -> navigator.notification.alert "FAILURE in hiding without animation"
    }

  @testShowDisableAnimation: () ->
    opened = () ->
      navigator.notification.alert "SUCCESS in opening modal"

    hideView = new steroids.views.WebView {
      location: "/views/modal/hide.html"
    }

    steroids.modal.show {
      view: hideView
      disableAnimation: true
    }, {
      onSuccess: opened
      onFailure: -> navigator.notification.alert "FAILURE in showing without animation"
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
      onSuccess: -> steroids.logger.log "SUCCESS in updating nav bar buttons"
      onFailure: -> navigator.notification.alert "failed to update nav bar buttons"

  @testSetAppearanceToRainbow: ->
    steroids.view.navigationBar.setAppearance {
      tintColor: '#FF0000'
      titleTextColor: '#0000FF'
      buttonTintColor: '#00FF00'
      buttonTitleTextColor: '#FF7F00'
      portraitBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
      landscapeBackgroundImage: steroids.app.path + '/images/navbar-bg@2x.png'
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS tasted the rainbow"
      onFailure: -> navigator.notification.alert "FAILURE in testSetAppearanceToRainbow - failed set nav bar appearance"
    }

  #orientation tests

  @testModalInLandscape: ->
    opened = () ->
      steroids.logger.log "SUCCESS opened modal in landscape"

    landscapeModal = new steroids.views.WebView "/views/modal/modalLandscape.html"

    steroids.modal.show {
      view: landscapeModal,
      allowedRotations: ["landscapeLeft", "landscapeRight"]
    }, {
      onSuccess: opened
      onFailure: -> navigator.notification.alert "FAILURE in testModalInLandscape"
    }

  @testModalInPortrait: ->
    opened = () ->
      steroids.logger.log "SUCCESS opened modal in portrait"

    landscapeModal = new steroids.views.WebView "/views/modal/modalPortrait.html"

    steroids.modal.show {
      view: landscapeModal,
      allowedRotations: ["portrait", "portraitUpsideDown"]
    }, {
      onSuccess: opened
      onFailure: -> navigator.notification.alert "FAILURE in testModalInPortrait"
    }

  #event tests

  @testWillShowChangeEvent: ->
    eventHandler = steroids.modal.on 'willshow', (event) ->
      navigator.notification.alert "willshow event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    steroids.logger.log "SUCCESS will show event listener added"

  @testDidShowChangeEvent: ->
    eventHandler = steroids.modal.on 'didshow', (event) ->
      navigator.notification.alert "didshow event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    steroids.logger.log "SUCCESS did show event listener added"

  @testWillCloseChangeEvent: ->
    eventHandler = steroids.modal.on 'willclose', (event) ->
      navigator.notification.alert "willclose event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    steroids.logger.log "SUCCESS will close event listener added"

  @testDidCloseChangeEvent: ->
    eventHandler = steroids.modal.on 'didclose', (event) ->
      navigator.notification.alert "didclose event -> eventName: #{event.name} target.webview.id: #{event.target.webview.id}"

    steroids.logger.log "SUCCESS did close event listener added"

  @testRemoveShowEvents: ->
    steroids.modal.off 'willshow'
    steroids.modal.off 'didshow'

    steroids.logger.log "SUCCESS modal show events handlers removed"

  @testRemoveCloseEvents: ->
    steroids.modal.off 'willclose'
    steroids.modal.off 'didclose'

    steroids.logger.log "SUCCESS modal close events handlers removed"

  @testGetApplicationState: ->
    steroids.getApplicationState {},
      onSuccess: (appState) ->
        steroids.logger.log appState
        steroids.logger.log "SUCCESS in receiving app state, see horrible mess of JSON string"
      onFailure: () ->
        navigator.notification.alert "FAILURE application state not received"



    
