class window.AppController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "app" }

  @path: ->

  @testPath: () ->
    alert JSON.stringify(steroids.app.path)

  @testUserFilesPath: ->
    alert JSON.stringify(steroids.app.userFilesPath)

  @testAbsolutePath: () ->
    alert JSON.stringify(steroids.app.absolutePath)

  @testGetLaunchURL: ->
    alert steroids.app.getLaunchURL()

  @testOpenSteroidsScannerURL: ->
    steroids.openURL("steroids-scanner://base/path?first=1&second=2")

  @testOpenGoogleURL: ->
    steroids.openURL("http://www.google.com")

  @testAddEventListenerForResumeAndAlertGetLaunchURL: ->
    alert "set eventlistener for resume"

    document.addEventListener "resume", () ->
      alert steroids.app.getLaunchURL()

  @testHostGetURL: ->
    steroids.app.host.getURL {},
      onSuccess: (msg) ->
        alert msg

  @testGetMode: ->
    steroids.app.getMode {},
      onSuccess: (msg) ->
        alert msg
