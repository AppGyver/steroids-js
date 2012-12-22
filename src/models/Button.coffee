# Button description
class Button extends NativeObject
  # ### Steroids.navigationBar.rightButton.show
  #  Show a button on the right side of navigation bar
  #
  # #### Example:
  # Steroids.navigationBar.rightButton.show({
  #   title: 'Settings'
  # },{
  #   onSuccess: function() {
  #     console.log("Button set.");
  #   },
  #   onRecurring: function() {
  #     console.log("User tapped the button");
  #   }
  # });
  #
  show: (options, callbacks={})->
    @nativeCall
      method: "showNavigationBarRightButton"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
      recurringCallbacks: [callbacks.onRecurring]
