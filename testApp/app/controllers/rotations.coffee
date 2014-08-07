class window.RotationsController

  ## steroids.screen.setAllowedRotations

  @testAllowPortrait: ->
    steroids.screen.setAllowedRotations "portrait"

  @testAllowPortraitUpsideDown: ->
    steroids.screen.setAllowedRotations "portraitUpsideDown"

  @testAllowLandscapeLeft: ->
    steroids.screen.setAllowedRotations "landscapeLeft"

  @testAllowLandscapeRight: ->
    steroids.screen.setAllowedRotations "landscapeRight"

  @testAllowAll: ->
    steroids.screen.setAllowedRotations ["portrait", "portraitUpsideDown", "landscapeLeft", "landscapeRight"]

  @testAllowAllWithDegrees: ->
    steroids.screen.setAllowedRotations ["0", 90, -90, "180"]

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
      onSuccess: -> steroids.logger.log "Allowed rotation to 0 (portrait)."
      onFailure: -> steroids.logger.log "Could not set allowed rotations to 0 (portrait)."
    }

  @testLegacyAllowRotation90: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [90]
    }, {
      onSuccess: -> steroids.logger.log "Allowed rotation to 90 (landscape)."
      onFailure: -> steroids.logger.log "Could not set allowed rotations to 0 (portrait)."
    }

  @testLegacyAllowRotationAll: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 90, 180, -90]
    }, {
      onSuccess: -> steroids.logger.log "Allowed rotation to all orientations."
      onFailure: -> steroids.logger.log "Could not set allowed rotations to all orientations."
    }

  @testLegacyAllowRotationHorizontal: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [-90, 90]
    }, {
      onSuccess: -> steroids.logger.log "Allowed rotation to horizontal orientations."
      onFailure: -> steroids.logger.log "Could not set allowed rotations to horizontal orientations."
    }

  @testLegacyAllowRotationVertical: ->
    steroids.view.setAllowedRotations {
      allowedRotations: [0, 180]
    }, {
      onSuccess: -> steroids.logger.log "Allowed rotation to vertical orientations."
      onFailure: -> steroids.logger.log "Could not set allowed rotations to vertical orientations."
    }

  @testLegacyRotateTo0: () ->
    steroids.view.rotateTo(0)

  @testLegacyRotateTo90: () ->
    steroids.view.rotateTo(90)

  @testLegacyRotateTo180: () ->
    steroids.view.rotateTo(180)

  @testLegacyRotateToNeg90: () ->
    steroids.view.rotateTo(-90)