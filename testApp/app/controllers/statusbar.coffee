class window.StatusbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "statusbar" }

  @testHide: ->
    steroids.statusBar.hide {},
      onSuccess: -> steroids.logger.log "SUCCESS in hiding status bar"
      onFailure: -> navigator.notification.alert "FAILURE in testHide status bar"

  @testShow: ->
    steroids.statusBar.show {},
      onSuccess: -> steroids.logger.log "SUCCESS in showing status bar"
      onFailure: -> navigator.notification.alert "FAILURE in testShow status bar"

  @testShowLight: ->
    steroids.statusBar.show "light",
      onSuccess: -> steroids.logger.log "SUCCESS in showing status bar in light colors"
      onFailure: -> navigator.notification.alert "FAILURE in testShowLight status bar"

  @testOnTap: ->
    steroids.statusBar.onTap -> navigator.notification.alert "TEST status bar tapped !!",
      onSuccess: -> steroids.logger.log "SUCCESS in setting onTap event for status bar"
      onFailure: -> navigator.notification.alert "FAILURE in testOnTap status bar"

  @testHideNavBarAnimated: ->
    steroids.view.navigationBar.hide {
      animated: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in hiding navigation bar with animation in status bar tests"
      onFailure: -> navigator.notification.alert "FAILURE in testHideNavBarAnimated in status bar tests"
    }

  @testShowNavBarAnimated: ->
    steroids.view.navigationBar.show {
      animated: true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in showing navigation bar with animation in status bar tests"
      onFailure: -> navigator.notification.alert "FAILURE in testShowNavBarAnimated in status bar tests"
    }