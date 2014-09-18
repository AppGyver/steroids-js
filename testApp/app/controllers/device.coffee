class window.DeviceController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "platform" }

  @testPing: () ->
    success = (e) ->
      steroids.logger.log "SUCCESS in getting message, message is: " + e.message
    failure = ->
      steroids.logger.log "FAILURE in testPing"
      navigator.notification.alert "FAILURE in testPing"

    steroids.device.ping({},{ 
      onSuccess: success
      onFailure: failure
    })

  @testGetIPAddress: () ->
    success = (e) ->
      steroids.logger.log "SUCCESS in getting IP address: " + e.ipAddress
    failure = () ->
      steroids.logger.log "FAILURE in testGetIPAddress"
      navigator.notification.alert "FAILURE in testGetIPAddress"


    steroids.device.getIPAddress {
    }, {
      onSuccess: success
      onFailure: failure
    }

  @testTorchOn: () ->

    steroids.device.torch.turnOn {
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in switching torch on"
      onFailure: () -> 
        steroids.logger.log "FAILURE in testTorchOn"
        navigator.notification.alert "FAILURE in testTorchOn"
    }

  @testTorchOff: () ->

    steroids.device.torch.turnOff {
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in switching torch off"
      onFailure: () ->
        steroids.logger.log "FAILURE in testTorchOff"
        navigator.notification.alert "FAILURE in testTorchOff"
    }

  @testTorchToggle: () ->

    steroids.device.torch.toggle {
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in toggling torch on/off"
      onFailure: () ->
        steroids.logger.log "FAILURE in testTorchToggle"
        navigator.notification.alert "FAILURE in testTorchToggle"
    }

  @testEnableSleep: ()->
    steroids.device.enableSleep {}, {
      onSuccess: () -> steroids.logger.log "SUCCESS in enabling device to go to sleep"
      onFailure: () ->
        steroids.logger.log "FAILURE in testEnableSleep"
        navigator.notification.alert "FAILURE in testEnableSleep"
    }

  @testDisableSleep: ()->
    steroids.device.disableSleep {}, {
      onSuccess: () -> steroids.logger.log "SUCCESS in disabling device sleep"
      onFailure: () -> 
        steroids.logger.log "FAILURE in testDisableSleep"
        navigator.notification.alert "FAILURE in testDisableSleep"
    }

  @testPlatformGetName: () ->
    steroids.device.platform.getName {},
      onSuccess: (gotName)-> steroids.logger.log "SUCCESS in getting platform name, it is: " + gotName
      onFailure: () ->
        steroids.logger.log "FAILURE in testPlatformGetName"
        navigator.notification.alert "FAILURE in testPlatformGetName"