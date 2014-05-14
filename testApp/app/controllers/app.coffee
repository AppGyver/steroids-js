class window.AppController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "app" }

  @path: ->

  @testPath: () ->
    notification JSON.stringify(steroids.app.path)

  @testUserFilesPath: ->
    notification JSON.stringify(steroids.app.userFilesPath)

  @testAbsolutePath: () ->
    notification JSON.stringify(steroids.app.absolutePath)

  @testGetLaunchURL: ->
    notification steroids.app.getLaunchURL()

  @testOpenSteroidsScannerURL: ->
    steroids.openURL("steroids-scanner://base/path?first=1&second=2")

  @testOpenGoogleURL: ->
    steroids.openURL("http://www.google.com")

  @testAddEventListenerForResumeAndAlertGetLaunchURL: ->
    notification "set eventlistener for resume"

    document.addEventListener "resume", () ->
      alert steroids.app.getLaunchURL()

  @testHostGetURL: ->
    steroids.app.host.getURL {},
      onSuccess: (msg) ->
        notification msg

  @testGetMode: ->
    steroids.app.getMode {},
      onSuccess: (msg) ->
        notification msg

  @testGetNSUserDefaults: ->
    steroids.app.getNSUserDefaults {},
      onSuccess: (obj) ->
        steroids.logger.log obj
