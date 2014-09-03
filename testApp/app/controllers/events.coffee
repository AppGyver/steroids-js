class window.EventsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testSteroidsReady: () ->
    steroids.on "ready", () ->
      navigator.notification.alert "I was called inside steroids ready"

  @testDeviceReady: () ->
    document.addEventListener "deviceready", ->
      navigator.notification.alert "I was called inside deviceready"