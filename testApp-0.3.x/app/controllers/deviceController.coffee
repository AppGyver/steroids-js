class window.DeviceController

  @testPing: () ->

    gotPong = (e) ->
      alert e.message

    steroids.device.ping({}, { onSuccess: gotPong })