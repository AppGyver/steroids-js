class window.TabbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "tabbar" }

  @testHide: ->
    steroids.tabBar.hide {},
      onSuccess: -> notification "hidden"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.tabBar.show {},
      onSuccess: -> notification "showed"
      onFailure: -> alert "failed to show"

  @testUpdate: ->
    steroids.tabBar.update({
      tabs:
        [
          {
            title: "http"
            icon: "icons/telescope@2x.png"
            badge: "1"
          },
          {
            title: "FILEurl"
            icon: "icons/telescope@2x.png"
            badge: "lol"
          },
          {
            title: "NOjs"
            icon: "icons/telescope@2x.png"
          }
        ]
      },
      onSuccess: -> notification "updated"
      onFailure: -> alert "failed to update"
    )

  @resetBadges: ->
    steroids.tabBar.update({
      tabs:
        [
          {
            badge: ""
          },
          {
            badge: ""
          },
          {
            badge: ""
          }
        ]
      },
      onSuccess: -> notification "updated"
      onFailure: -> alert "failed to update"
    )

  @testSelectTab: ->
    steroids.tabBar.selectTab 1

  @testUpdateTab: ->
    steroids.tabBar.currentTab.update({
      title: "New Title"
      image_path: "icons/shoebox@2x.png"
      badge: "1"
    },
    onSuccess: ->
      notification "Success updating curent tab"
    onFailure: (failure) ->
      console.log "Failed to update current tab", failure
      alert "Failed to update current tab"
    )

  @willChangeHandlers = []
  @didChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.tabBar.on 'willchange', (event) ->
      alert "willchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @willChangeHandlers.push eventHandler

    notification "event listener added"

  @testdidchangeEvent: ->
    eventHandler = steroids.tabBar.on 'didchange', (event) ->
      alert "didchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @didChangeHandlers.push eventHandler

    notification "event listener added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    notification "event handlers removed"

  @testRemoveDidChangeEvents: ->
    steroids.tabBar.off 'didchange'

    notification "didchange events handlers removed"

  @testRemoveWillChangeEvents: ->
    steroids.tabBar.off 'willchange'

    notification "willchange events handlers removed"

