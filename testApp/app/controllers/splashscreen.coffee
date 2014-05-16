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
        alert("Splash shown, will dissmiss after 3000ms if set in config.xml or after 5000ms (timeout)")
      onFailure: -> alert "failed to show"

    setTimeout ->
      steroids.splashscreen.hide()
    , 5000

  @testHide: ->
    steroids.splashscreen.hide {},
      onSuccess: -> alert "hided"
      onFailure: -> alert "failed to show"

  @testShowHide: ->
    steroids.splashscreen.show()

    setTimeout ->
      steroids.splashscreen.hide()
    , 1000
