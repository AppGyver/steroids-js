class window.ScreenController

  @index: ->
    steroids.navigationBar.show "Screen"

  @testFreeze: ->
    steroids.screen.freeze {},
      onSuccess: -> steroids.logger.log "SUCCESS in freezing the screen"
      onFailure: -> navigator.notification.alert "FAILURE in testFreeze freezing the screen"

    unfreezer = ()->
      steroids.screen.unfreeze {},
        onSuccess: -> steroids.logger.log "SUCCESS in unfreezing the screen"
        onFailure: -> navigator.notification.alert "FAILURE in testFreeze in unfreezing the screen"

    setTimeout unfreezer, 1000

  @testCapture: ->
    steroids.screen.capture {},
      onSuccess: (params)->
        img = document.createElement 'img'
        img.setAttribute 'src', params.screenshot
        captureResult.innerHTML = ""
        captureResult.appendChild img
        steroids.logger.log "SUCCESS in capturing screen"
      onFailure: ->
        navigator.notification.alert "FAILURE in capturing the screen testCapture"

  @testTap: ->
    steroids.logger.log "TEST firing tap soon"
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
