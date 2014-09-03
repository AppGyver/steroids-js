class window.SteroidsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "steroids" }

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

  @testSteroidsDefined: () ->
    alert steroids?

  @testCordovaDefined: () ->
    alert cordova?

  @testJSCoreBridgeImplDefined: () ->
    alert __JSCoreBridgeImpl?

  @testReloadPage: () ->
    window.location.reload()

  @testOpenURLGoogle: () ->
    steroids.openURL {
      url: "http://www.google.com"
    }, {
      onSuccess: () -> alert "google opened externally"
      onFailure: () -> alert "failed to open google externally"
    }

  @testOpenURLMaps: () ->
    steroids.openURL {
      url: "maps://"
    }, {
      onSuccess: () -> alert "maps opened"
      onFailure: () -> alert "failed to open maps"
    }

  @testOpenURLMapsAndroid: () ->
    steroids.openURL {
      url: "geo:42,2?z=8"
    }, {
      onSuccess: () -> alert "maps opened"
      onFailure: () -> alert "failed to open maps"
    }
