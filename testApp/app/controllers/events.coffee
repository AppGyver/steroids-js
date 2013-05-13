class window.EventsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testSteroidsReady: () ->
    steroids.on "ready", () ->
      alert "I was called inside steroids ready"

  @testDeviceReady: () ->
    document.addEventListener "deviceready", ->
      alert "I was called inside deviceready"