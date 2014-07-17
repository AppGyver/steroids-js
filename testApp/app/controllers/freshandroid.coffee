class window.FreshandroidController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    list = document.getElementById("ready")
    el = document.createElement("li")
    el.innerHTML = (new Date()).toLocaleTimeString() + " Cordova READY"
    list.appendChild(el)

  # Steroids ready event 
  steroids.on 'ready' , ->

    list = document.getElementById("ready")
    el = document.createElement("li")
    el.innerHTML = (new Date()).toLocaleTimeString() + " Steroids READY"
    list.appendChild(el)

  # OpenURL
  @testOpenURLGoogle = () ->
    steroids.openURL {
      url: "http://www.google.com"
    }, {
      onSuccess: () -> navigator.notification.alert "google opened externally"
      onFailure: () -> navigator.notification.alert "failed to open google externally"
    }
  
  @testOpenURLMapsAndroid = () ->
    steroids.openURL {
      url: "geo:42,2?z=8"
    }, {
      onSuccess: () -> navigator.notification.alert "maps opened"
      onFailure: () -> navigator.notification.alert "failed to open maps"
    }
  
  # Status bar
  @testHide: ->
    steroids.statusBar.hide {},
      onSuccess: -> navigator.notification.alert "hided"
      onFailure: -> navigator.notification.alert "failed to hide"

  @testShow: ->
    steroids.statusBar.show {},
      onSuccess: -> navigator.notification.alert "showed"
      onFailure: -> navigator.notification.alert "failed to show"

  # Visibility State
  @testCurrentVisibilityIsVisible: () ->
    navigator.notification.alert "document.hidden = #{document.hidden}"
    navigator.notification.alert "document.visibilityState = #{document.visibilityState}"

  # Device  
  @testPing: () ->
    success = (e) ->
      navigator.notification.alert "SUCCESS in getting message, message is: " + e.message
    failure = ->
      navigator.notification.alert "FAILURE in testPing"

    steroids.device.ping({},{ 
      onSuccess: success
      onFailure: failure
    })

  @testGetIPAddress: () ->
    success = (e) ->
      navigator.notification.alert "SUCCESS in getting IP address: " + e.ipAddress
    failure = () ->
      navigator.notification.alert "FAILURE in testGetIPAddress"


    steroids.device.getIPAddress {
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testEnableSleep: ()->
    steroids.device.enableSleep {}, {
      onSuccess: () -> navigator.notification.alert "SUCCESS in enabling device to go to sleep"
      onFailure: () -> navigator.notification.alert "FAILURE in testEnableSleep"
    }

  @testDisableSleep: ()->
    steroids.device.disableSleep {}, {
      onSuccess: () -> navigator.notification.alert "SUCCESS in disabling device sleep"
      onFailure: () -> navigator.notification.alert "FAILURE in testDisableSleep"
    }

  # Unzip
  @createFile: (options={path:"test.png", relativeTo: steroids.app.absoluteUserFilesPath})->
    new steroids.File(options)

  @testUnzip: ->
    @createFile("test.zip").unzip "unzippedtest",
      onSuccess: (params)=>
        img = document.createElement 'img'
        img.setAttribute 'src', "/unzippedtest/success.png"
        fileResult.innerHTML = ""
        fileResult.appendChild img
        navigator.notification.alert "SUCCESS in unzipping image"
      onFailure: (error)=>
        navigator.notification.alert "FAILURE in testUnzip: #{JSON.stringify error}"

  # Path
  @testAbsoluteUserFilesPath: ->
    navigator.notification.alert JSON.stringify(steroids.app.absoluteUserFilesPath)

  @testAbsolutePath: () ->
    navigator.notification.alert JSON.stringify(steroids.app.absolutePath)

  # Rotate
  @testRotatePortrait: ->
    steroids.screen.rotate "portrait"
    ,
      onTransitionStarted: ->
        navigator.notification.alert "rotation started"
      onTransitionEnded: ->
        navigator.notification.alert "rotation ended"

  @testRotatePortraitUpsideDown: ->
    steroids.screen.rotate "portraitUpsideDown"

  @testRotateLandscapeLeft: ->
    steroids.screen.rotate "landscapeLeft"

  @testRotateLandscapeRight: ->
    steroids.screen.rotate "landscapeRight"