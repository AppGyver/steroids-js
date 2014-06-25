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
        steroids.logger.log "initialView.dismiss onSuccess"
      onFailure: (result) ->
        steroids.logger.log "initialView.dismiss onFailure"

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
        steroids.logger.log "initialView.show onSuccess"
      onFailure: (result) ->
        steroids.logger.log "initialView.show onFailure"
