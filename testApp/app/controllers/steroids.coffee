class window.SteroidsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "steroids" }

    now = new Date()
    diff = now.getTime() - window.___START_TIME.getTime()

    list = document.getElementById("ready")
    el = document.createElement("li")
    el.innerHTML = now.toLocaleTimeString() + " Cordova READY - " + diff + " ms since page load"
    list.appendChild(el)

    # Steroids ready event
    steroids.on 'ready' , ->

      now = new Date()
      diff = now.getTime() - window.___START_TIME.getTime()

      list = document.getElementById("ready")
      el = document.createElement("li")
      el.innerHTML = now.toLocaleTimeString() + " Steroids READY - " + diff + " ms since page load"
      list.appendChild(el)

  @testSteroidsDefined: () ->
    navigator.notification.alert "#{steroids?}"

  @testCordovaDefined: () ->
    navigator.notification.alert "#{cordova?}"

  @testJSCoreBridgeImplDefined: () ->
    navigator.notification.alert __JSCoreBridgeImpl?

  @testReloadPage: () ->
    window.location.reload()

  @testOpenURLGoogle: () ->
    steroids.openURL {
      url: "http://www.google.com"
    }, {
      onSuccess: () -> steroids.logger.log "google opened externally"
      onFailure: () -> navigator.notification.alert "failed to open google externally"
    }

  @testOpenURLMaps: () ->
    steroids.openURL {
      url: "maps://"
    }, {
      onSuccess: () -> steroids.logger.log "maps opened"
      onFailure: () -> navigator.notification.alert "failed to open maps"
    }

  @testOpenURLMapsAndroid: () ->
    steroids.openURL {
      url: "geo:42,2?z=8"
    }, {
      onSuccess: () -> steroids.logger.log "maps opened"
      onFailure: () -> navigator.notification.alert "failed to open maps"
    }
