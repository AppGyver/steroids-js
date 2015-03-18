class window.AppController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "app" }

  @path: ->

  @testLoadTheme_default: ->
    steroids.app.loadTheme "default.css"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testLoadTheme_default"
      onFailure: -> navigator.notification.alert "FAILURE in testLoadTheme_default"


  @testLoadTheme_green: ->
    steroids.app.loadTheme "green-theme.css"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testLoadTheme_green"
      onFailure: -> navigator.notification.alert "FAILURE in testLoadTheme_green"

  @testLoadTheme_red: ->
    steroids.app.loadTheme "red-theme.css"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testLoadTheme_red"
      onFailure: -> navigator.notification.alert "FAILURE in testLoadTheme_red"

  @testPath: () ->
    navigator.notification.alert JSON.stringify(steroids.app.path)

  @testUserFilesPath: ->
    navigator.notification.alert JSON.stringify(steroids.app.userFilesPath)

  @testAbsolutePath: () ->
    navigator.notification.alert JSON.stringify(steroids.app.absolutePath)

  @testGetLaunchURL: ->
    navigator.notification.alert steroids.app.getLaunchURL()

  @testOpenSteroidsScannerURL: ->
    steroids.openURL("steroids-scanner://base/path?first=1&second=2")

  @testOpenGoogleURL: ->
    steroids.openURL("http://www.google.com")

  @testAddEventListenerForResumeAndAlertGetLaunchURL: ->
    navigator.notification.alert "set eventlistener for resume"

    document.addEventListener "resume", () ->
      alert steroids.app.getLaunchURL()

  @testHostGetURL: ->
    steroids.app.host.getURL {},
      onSuccess: (msg) ->
        navigator.notification.alert msg
      onFailure: ->
        navigator.notification.alert "error in getting url"

  @testGetMode: ->
    steroids.app.getMode {},
      onSuccess: (msg) ->
        navigator.notification.alert msg
      onFailure: ->
        navigator.notification.alert "error in getting mode"

  @testGetNSUserDefaults: ->
    steroids.app.getNSUserDefaults {},
      onSuccess: (obj) ->
        navigator.notification.alert "should return empty object, returned: #{obj}"
      onFailure: ->
        navigator.notification.alert "error in getting ns user defaults"

  @testGetLaunchURI: ->
    steroids.app.getLaunchURI {},
      onSuccess: (uri)->
        navigator.notification.alert "Launch URI is #{uri}"
      onFailure: (error)->
        navigator.notification.alert error.errorDescription

  @testGetLaunchURIOnResume: ->
    document.addEventListener "resume", =>
      @testGetLaunchURI()
