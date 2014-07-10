class window.ScreenController

  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.navigationBar.show { title: "screen" }

      steroids.view.setAllowedRotations [0, 90, -90, 180]

  @testFreeze: ->
    steroids.screen.freeze {},
      onSuccess: -> steroids.logger.log "freeze success"
      onFailure: -> steroids.logger.log "freeze failure"

    unfreezer = ()->
      steroids.screen.unfreeze {},
        onSuccess: -> steroids.logger.log "unfreeze success"
        onFailure: -> steroids.logger.log "unfreeze failure"

    setTimeout unfreezer, 1000

  @testCapture: ->
    steroids.screen.capture {},
      onSuccess: (params)->
        img = document.createElement 'img'
        img.setAttribute 'src', params.screenshot
        captureResult.innerHTML = ""
        captureResult.appendChild img


  @testTap: ->
    steroids.logger.log "firing tap soon"
    window.setTimeout ->
      steroids.screen.tap {
        x: 30
        y: 70
      }
    , 750

    window.setTimeout ->
      steroids.screen.tap {
        x: 160
        y: 260
      }
    , 1100

  @testAllowPortrait: ->
    steroids.screen.setAllowedRotations "portrait"

  @testAllowPortraitUpsideDown: ->
    steroids.screen.setAllowedRotations "portraitUpsideDown"

  @testAllowLandscapeLeft: ->
    steroids.screen.setAllowedRotations "landscapeLeft"

  @testAllowLandscapeRight: ->
    steroids.screen.setAllowedRotations "landscapeRight"

  @testRotatePortrait: ->
    steroids.screen.rotate "portrait"
    ,
      onTransitionStarted: ->
        steroids.logger.log "rotation started"
      onTransitionEnded: ->
        steroids.logger.log "rotation ended"

  @testRotatePortraitUpsideDown: ->
    steroids.screen.rotate "portraitUpsideDown"

  @testRotateLandscapeLeft: ->
    steroids.screen.rotate "landscapeLeft"

  @testRotateLandscapeRight: ->
    steroids.screen.rotate "landscapeRight"