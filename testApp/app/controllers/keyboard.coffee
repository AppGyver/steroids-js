class window.KeyboardController

  @testActionButtonPressed: ->
    @eventHandler = steroids.keyboard.on "actionButtonPressed", (params)->
      alert "actionButtonPressed event invoked -> params: #{JSON.stringify(params)}"

    alert "actionButtonPressed event handler attached"


  @testRemoveEventHandlerWithHandlerId: ->
    steroids.keyboard.off "actionButtonPressed", @eventHandler

    alert "actionButtonPressed event handler removed"

  @testRemoveEventHandlerByEventname: ->
    steroids.keyboard.off "actionButtonPressed"

    alert "all actionButtonPressed event handlers removed"