class window.ScreenController

  @index: ->
    steroids.navigationBar.show "Screen"

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
