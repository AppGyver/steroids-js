class window.ScreenController

  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.navigationBar.show { title: "screen" }

  @testFreeze: ->
    steroids.screen.freeze {},
      onSuccess: console.log "freeze success"
      onFailure: console.log "freeze failure"

    unfreezer = ()->
      steroids.screen.unfreeze {},
        onSuccess: console.log "unfreeze success"
        onFailure: console.log "unfreeze failure"

    setTimeout unfreezer, 1000

  @testCapture: ->
    steroids.screen.capture {},
      onSuccess: (params)->
        img = document.createElement 'img'
        img.setAttribute 'src', params.screenshot
        captureResult.innerHTML = ""
        captureResult.appendChild img


  @testTap: ->
    steroids.screen.tap {
      x: 10
      y: 80
    }