class window.DeviceController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "platform" }

  @testPing: () ->
    gotPong = (e) ->
      notification e.message

    steroids.device.ping({}, { onSuccess: gotPong })

  @testGetIPAddress: () ->
    showIPAddress = (e) ->
      notification e.ipAddress

    steroids.device.getIPAddress {
    }, {
      onSuccess: showIPAddress
    }

  @testTorchOn: () ->

    steroids.device.torch.turnOn {
    }, {
      onSuccess: () -> notification "turned on"
    }

  @testTorchOff: () ->

    steroids.device.torch.turnOff {
    }, {
      onSuccess: () -> notification "turned off"
    }

  @testTorchToggle: () ->

    steroids.device.torch.toggle {
    }, {
      onSuccess: () -> notification "toggled"
    }

  @testEnableSleep: ()->
    steroids.device.enableSleep {}, {
      onSuccess: () -> notification "enabled"
    }

  @testDisableSleep: ()->
    steroids.device.disableSleep {}, {
      onSuccess: () -> notification "disabled"
    }

  @testPlatformGetName: () ->
    steroids.device.platform.getName {},
      onSuccess: (gotName)-> notification gotName
