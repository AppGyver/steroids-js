class window.ScreenController

  @index: ->
    steroids.navigationBar.show "Screen"

  @testDismissNextAlert_with_index_0: ->

    steroids.screen.on "alertdidshow", (event) ->
      steroids.logger.log "alert did show event -> alert title: #{event.title}"

      steroids.screen.dismissAlert
        buttonIndex: 0
      ,
        onSuccess: ->
          steroids.logger.log "SUCCESS in setting dismissAlert"
        onFailure: -> navigator.notification.alert "FAILURE in dismissAlert"

    steroids.logger.log "SUCCESS in adding event listener -> alertDidShow"

    navigator.notification.alert "lol", ->
      steroids.logger.log "Successfully dismissed alert!"

  @testFreeze: ->
    steroids.screen.freeze {},
      onSuccess: -> steroids.logger.log "SUCCESS in freezing the screen"
      onFailure: -> navigator.notification.alert "FAILURE in testFreeze freezing the screen"

    unfreezer = ()->
      steroids.screen.unfreeze {},
        onSuccess: -> steroids.logger.log "SUCCESS in unfreezing the screen"
        onFailure: -> navigator.notification.alert "FAILURE in testFreeze in unfreezing the screen"

    setTimeout unfreezer, 1000

  @testCapturePNG: ->
    steroids.screen.capture {
      output:"png"
    },
      onSuccess: (params)->
        img = document.createElement 'img'
        img.setAttribute 'src', params.screenshot
        captureResult.innerHTML = ""
        captureResult.appendChild img
        steroids.logger.log "SUCCESS in capturing screen"
      onFailure: ->
        navigator.notification.alert "FAILURE in capturing the screen testCapture"

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
