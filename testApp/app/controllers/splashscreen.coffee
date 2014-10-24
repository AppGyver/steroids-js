class window.SplashscreenController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "splashscreen" }

  @testShow: ->
    onConfirm = ->
      steroids.splashscreen.hide()

    steroids.splashscreen.show {},
      onSuccess: ->
        steroids.logger.log("SUCCESS in showing splash screen, will dissmiss after 3000ms if set in config.xml or after 5000ms (timeout)")
      onFailure: -> navigator.notification.alert "FAILURE in showing the splash screen"

    setTimeout ->
      steroids.splashscreen.hide()
    , 5000

  @testHide: ->
    steroids.splashscreen.hide {},
      onSuccess: -> steroids.logger.log "SUCCESS in hiding the splash screen"
      onFailure: -> steroids.logger.log "FAILURE in hiding the splash screen"

  @testShowHide: ->
    steroids.splashscreen.show()

    setTimeout ->
      steroids.splashscreen.hide()
    , 1000
