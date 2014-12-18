class window.KeyboardController

  @testActionButtonPressed: ->
    @eventHandler = steroids.keyboard.on "actionButtonPressed", (params)->
      navigator.notification.alert "actionButtonPressed event invoked -> params: #{JSON.stringify(params)}"

    navigator.notification.alert "actionButtonPressed event handler attached"


  @testRemoveEventHandlerWithHandlerId: ->
    steroids.keyboard.off "actionButtonPressed", @eventHandler

    navigator.notification.alert "actionButtonPressed event handler removed"

  @testRemoveEventHandlerByEventname: ->
    steroids.keyboard.off "actionButtonPressed"

    navigator.notification.alert "all actionButtonPressed event handlers removed"

  @testEnableKeyboardAccessory: () ->
    steroids.view.updateKeyboard {
      accessoryBarEnabled:true
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS keyboard accesssory enabled"
      onFailure: (error) -> navigator.notification.alert "FAILURE in testEnableKeyboardAccessory:\n\n#{error.errorDescription}"
    }

  @testDisableKeyboardAccessory: () ->
    steroids.view.updateKeyboard {
      accessoryBarEnabled:false
    }, {
      onSuccess: -> steroids.logger.log "SUCCESS keyboard accesssory disabled"
      onFailure: (error) -> navigator.notification.alert "FAILURE in testDisableKeyboardAccessory:\n\n#{error.errorDescription}"
    }

  @testKeyboardAccessoryWithEmptyParams: () ->
    steroids.view.updateKeyboard null, {
      onSuccess: -> steroids.logger.log "SUCCESS updateKeyboard called with no parameters (no change)"
      onFailure: (error) -> navigator.notification.alert "FAILURE in testKeyboardAccessoryWithEmptyParams:\n\n#{error.errorDescription}"
    }

  @testInPreloadedView: () ->
    thisView = new steroids.views.WebView "/views/keyboard/index.html"

    thisView.preload({}, {
      onSuccess: ->
        steroids.layers.push thisView
      onFailure: ->
        steroids.layers.push thisView
    })
