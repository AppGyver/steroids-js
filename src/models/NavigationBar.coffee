# Navigation bar description
class NavigationBar extends NativeObject
  constructor: ->

  # Singleton Button representing the button on the right side of navigation bar.
  rightButton: new Button

  # ### Steroids.navigationBar.show
  #
  # Show navigationBar in current layer
  #
  # Parameters:
  #   title:
  #     Text visible in the center of navigation bar.
  #
  # #### Example:
  #
  # Steroids.navigationBar.show({
  #   title: 'My Nav Title'
  # },{
  #   onSuccess: function() {
  #     console.log("Navigation bar is now visible");
  #   },
  #   onFailure: function(e) {
  #     console.log("Navigation bar could not be shown: " + e);
  #   }
  # });
  #
  show: (options={}, callbacks={})->
    @nativeCall
      method: "showNavigationBar"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
