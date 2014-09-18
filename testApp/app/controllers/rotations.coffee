class window.RotationsController

  ## steroids.screen.setAllowedRotations

  @testAllowPortrait: ->
    steroids.screen.setAllowedRotations "portrait",
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only portrait orientation"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowPortrait rotations"

  @testAllowPortraitUpsideDown: ->
    steroids.screen.setAllowedRotations "portraitUpsideDown",
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only upside-down portrait orientation"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowPortraitUpsideDown"

  @testAllowLandscapeLeft: ->
    steroids.screen.setAllowedRotations "landscapeLeft",
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only landscape left orientation"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowLandscapeLeft"

  @testAllowLandscapeRight: ->
    steroids.screen.setAllowedRotations "landscapeRight",
      onSuccess: -> steroids.logger.log "SUCCESS in allowing only landscape right orientation"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowLandscapeRight"

  @testAllowAll: ->
    steroids.screen.setAllowedRotations ["portrait", "portraitUpsideDown", "landscapeLeft", "landscapeRight"],
      onSuccess: -> steroids.logger.log "SUCCESS in allowing all orientations and rotations by using the names of the orientations"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowAll rotations"

  @testAllowAllWithDegrees: ->
    steroids.screen.setAllowedRotations ["0", 90, -90, "180"],
      onSuccess: -> steroids.logger.log "SUCCESS in allowing all orientations and rotations by using the degrees"
      onFailure: -> navigator.notification.alert "FAILURE in testAllowAllWithDegrees"

  ## steroids.screen.rotate
  _rotationOptions =
    onTransitionStarted: ->
      steroids.logger.log "Rotation started!"
    onTransitionEnded: ->
      steroids.logger.log "Rotation ended!"

  @testRotatePortrait: ->
    steroids.screen.rotate "portrait"
    , _rotationOptions

  @testRotatePortraitUpsideDown: ->
    steroids.screen.rotate "portraitUpsideDown"
    , _rotationOptions

  @testRotateLandscapeLeft: ->
    steroids.screen.rotate "landscapeLeft"
    , _rotationOptions

  @testRotateLandscapeRight: ->
    steroids.screen.rotate "landscapeRight"
    , _rotationOptions


  ## Legacy view namespace function

  @testLegacyAllowRotation0: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0]
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS Allowed rotation to 0 (portrait)."
      onFailure: -> steroids.logger.log "FAILURE in testLegacyAllowRotation0 - Could not set allowed rotations to 0 (portrait)."
    }

  @testLegacyAllowRotation90: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [90]
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in Allowed rotation to 90 (landscape)."
      onFailure: -> steroids.logger.log "FAILURE in testLegacyAllowRotation90 - Could not set allowed rotations to 0 (portrait)."
    }

  @testLegacyAllowRotationAll: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 90, 180, -90]
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in Allowed rotation to all orientations."
      onFailure: -> steroids.logger.log "FAILURE in testLegacyAllowRotationAll - Could not set allowed rotations to all orientations."
    }

  @testLegacyAllowRotationHorizontal: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [-90, 90]
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in Allowed rotation to horizontal orientations."
      onFailure: -> steroids.logger.log "FAILURE in testLegacyAllowRotationHorizontal - Could not set allowed rotations to horizontal orientations."
    }

  @testLegacyAllowRotationVertical: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 180]
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS in Allowed rotation to vertical orientations."
      onFailure: -> steroids.logger.log "FAILURE in testLegacyAllowRotationVertical - Could not set allowed rotations to vertical orientations."
    }

  @testLegacyRotateTo0: () ->
    steroids.view.rotateTo(0)

  @testLegacyRotateTo90: () ->
    steroids.view.rotateTo(90)

  @testLegacyRotateTo180: () ->
    steroids.view.rotateTo(180)

  @testLegacyRotateToNeg90: () ->
    steroids.view.rotateTo(-90)