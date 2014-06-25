class window.InitviewController

  @testTest: ->
    alert "test test"

  @testDismissInitialView: ->
    steroids.logger.log "@testDismissInitialView called"
    myAnimation = new steroids.Animation
      transition: "flipHorizontalFromRight"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.dismiss
      animation: myAnimation
    ,
      onSuccess: (result) ->
        steroids.logger.log "SUCCESS in dismissing initial view"
      onFailure: (result) ->
        steroids.logger.log "FAILURE in testDismissInitialView"

  @testResetAppToInitialView: ->
    steroids.logger.log "@testResetAppToInitialView called"
    myAnimation = new steroids.Animation
      transition: "slideFromBottom"
      duration: 1.0
      curve: "easeInOut"

    steroids.initialView.show
      animation: myAnimation
    ,
      onSuccess: (result) ->
        steroids.logger.log "SUCCESS in showing initial view"
      onFailure: (result) ->
        steroids.logger.log "FAILURE in testResetAppToInitialView"
