class window.EventsController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

  @testSteroidsReady: () ->
    steroids.on "ready", () ->
      notification "I was called inside steroids ready"

  @testDeviceReady: () ->
    document.addEventListener "deviceready", ->
      notification "I was called inside deviceready"
