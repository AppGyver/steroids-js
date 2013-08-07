class window.DeviceController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "device" }

  @testPing: () ->
    gotPong = (e) ->
      alert e.message

    steroids.device.ping({}, { onSuccess: gotPong })

  @testGetIPAddress: () ->
    showIPAddress = (e) ->
      alert e.ipAddress

    steroids.device.getIPAddress {
    }, {
      onSuccess: showIPAddress
    }

  @testTorchOn: () ->

    steroids.device.torch.turnOn {
    }, {
      onSuccess: () -> alert "turned on"
    }

  @testTorchOff: () ->

    steroids.device.torch.turnOff {
    }, {
      onSuccess: () -> alert "turned off"
    }

  @testTorchToggle: () ->

    steroids.device.torch.toggle {
    }, {
      onSuccess: () -> alert "toggled"
    }

  @testEnableSleep: ()->
    steroids.device.enableSleep {}, {
      onSuccess: () -> alert "enabled"
    }

  @testDisableSleep: ()->
    steroids.device.disableSleep {}, {
      onSuccess: () -> alert "disabled"
    }
