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