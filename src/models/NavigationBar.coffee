# Navigation bar description
class NavigationBar extends NativeObject
  constructor: ->

  # ###Steroids.navigationBar.rightButton
  #
  # ####Example:
  #     Steroids.navigationBar.rightButton({
  #         title: 'Settings'
  #     }, {
  #       onSuccess: function(){
  #         // button was set
  #       }
  #     })
  rightButton: new Button

  # ###Steroids.navigationBar.show
  #
  #   Show navigationBar in current layer
  #
  # ####Example:
  #     Steroids.navigationBar.show({
  #         title: 'My Nav Title'
  #     }, {
  #       onSuccess: function(){
  #         // navigation bar was set
  #       }
  #     })
  show: (options, callbacks={})->
    @nativeCall
      method: "showNavigationBar"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # TODO: implement this
  setTitle: (options, callbacks)->
    whenSet = () ->
      @.title = options.title