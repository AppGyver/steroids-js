class NavigationBar extends SteroidsNativeObject
  constructor: ->
    #TODO:
    # Use context

  #
  # Steroids.navigationBar.setTitle({ title: "Kikuli"}, {onFailure: kusi })
  #
  setTitle: (options, userCallbacks)->
    whenSet = () ->
      @.title = options.title
      @.emit "change", options

    natiiviSilta
      method: "setNavigationBarTitle"
      options: options
      failureCallbacks: [ whenFucked, userCallbacks.onSuccess]
      successCallbacks: [ whenUnfucked, userCallbacks.onFailure ]

