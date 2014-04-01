class window.TabbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "tabbar" }

  @testHide: ->
    steroids.tabBar.hide {},
      onSuccess: -> alert "hided"
      onFailure: -> alert "failed to hide"

  @testShow: ->
    steroids.tabBar.show {},
      onSuccess: -> alert "showed"
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
      onSuccess: -> alert "updated"
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
      onSuccess: -> alert "updated"
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
      alert "Success updating curent tab"
    onFailure: (failure) ->
      console.log "Failed to update current tab", failure
      alert "Failed to update current tab"
    )

  @willChangeHandlers = []
  @didChangeHandlers = []

  @testTabWillChangeEvent: ->
    eventHandler = steroids.tabBar.on 'tabwillchange', (event) ->
      alert "tabwillchange event -> eventName: #{event.name} targetTabTitle: #{event.targetTabTitle} sourceTabTitle: #{event.sourceTabTitle}"

    @willChangeHandlers.push eventHandler

    alert "event listener added"

  @testTabDidChangeEvent: ->
    eventHandler = steroids.tabBar.on 'tabdidchange', (event) ->
      alert "tabdidchange event -> eventName: #{event.name} targetTabTitle: #{event.targetTabTitle} sourceTabTitle: #{event.sourceTabTitle}"

    @didChangeHandlers.push eventHandler

    alert "event listener added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'tabdidchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'tabwillchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    alert "event handlers removed"

  @testRemoveDidChangeEvents: ->
    steroids.tabBar.off 'tabdidchange'

    alert "tabdidchange events handlers removed"

  @testRemoveWillChangeEvents: ->
    steroids.tabBar.off 'tabwillchange'

    alert "tabwillchange events handlers removed"

