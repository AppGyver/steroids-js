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

  @testUpdateTop: ->
    steroids.tabBar.update {
      position: 'top'
    },
    onSuccess: -> alert "updated"
    onFailure: -> alert "failed to update"

  @testUpdateBottom: ->
    steroids.tabBar.update {
      position: 'bottom'
    },
    onSuccess: -> alert "updated"
    onFailure: -> alert "failed to update"


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
      steroids.logger.log "Failed to update current tab", failure
      alert "Failed to update current tab"
    )

  @willChangeHandlers = []
  @didChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.tabBar.on 'willchange', (event) ->
      alert "willchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @willChangeHandlers.push eventHandler

    alert "event listener added"

  @testdidchangeEvent: ->
    eventHandler = steroids.tabBar.on 'didchange', (event) ->
      alert "didchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @didChangeHandlers.push eventHandler

    alert "event listener added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    alert "event handlers removed"

  @testRemoveDidChangeEvents: ->
    steroids.tabBar.off 'didchange'

    alert "didchange events handlers removed"

  @testRemoveWillChangeEvents: ->
    steroids.tabBar.off 'willchange'

    alert "willchange events handlers removed"

  @testReplaceTabsInvertedOrder: ->

    options =
      tabs: [
        location: "http://localhost/views/plugin/index.html"
        title: "Cordova"
        position: 3
        icon: "icons/telescope@2x.png"
      ,
        location: "nojs.html"
        title: "noJS"
        position: 2
        icon: "icons/telescope@2x.png"
      ,
        location: "views/steroids/index.html"
        title: "FileURL"
        position: 1
        icon: "icons/shoebox@2x.png"
      ,
        location: "http://localhost/views/steroids/index.html"
        title: "HTTP"
        position: 0
        icon: "icons/telescope@2x.png"
      ]

    callBacks =
      onSuccess: () ->
        alert "replace tabs onSuccess"
      onFailure: () ->
        alert "replace tabs onFailure"


    steroids.tabBar.replace options, callBacks


  @testReplaceTabsOriginalOrder: ->

    options =
      tabs: [
        location: "http://localhost/views/steroids/index.html"
        title: "HTTP"
        position: 0
        icon: "icons/pill@2x.png"
      ,
        location: "views/steroids/index.html"
        title: "FileURL"
        position: 1
        icon: "icons/shoebox@2x.png"
      ,
        location: "nojs.html"
        title: "noJS"
        position: 2
        icon: "icons/shoebox@2x.png"
      ,
        location: "http://localhost/views/plugin/index.html"
        title: "Cordova"
        position: 3
        icon: "icons/telescope@2x.png"
      ]

    callBacks =
      onSuccess: () ->
        alert "replace tabs onSuccess"
      onFailure: () ->
        alert "replace tabs onFailure"


    steroids.tabBar.replace options, callBacks

  @testReplaceTabsNoParams: ->
    callBacks =
      onSuccess: () ->
        alert "replace tabs no params onSuccess"
      onFailure: () ->
        alert "replace tabs no params onFailure"

    steroids.tabBar.replace null, callBacks

  @replaceTabsIntervalId = 0;

  @repeatReplaceTabs: ->
    steroids.logger.log "repeatReplaceTabs -> will call replaceTabs in 2 seconds."
    setInterval ()->
      steroids.logger.log "repeatReplaceTabs -> calling replaceTabs ... "
      TabbarController.replaceTabs()
    ,
      2000

  @testRepeatReplaceTabs: ->

    TabbarController.replaceTabs()

  @replaceTabs: ->

    options =
      tabs: [
          location: "http://localhost/views/tabbar/replaceTabs.html"
          title: "Replace Tabs"
          position: 0
          icon: "icons/shoebox@2x.png"
        ,
          location: "http://localhost/views/steroids/index.html"
          title: "HTTP"
          position: 1
          icon: "icons/pill@2x.png"
        ,
          location: "views/steroids/index.html"
          title: "FileURL"
          position: 2
          icon: "icons/shoebox@2x.png"
      ]

    callBacks =
      onSuccess: () ->
        steroids.logger.log "repeatReplaceTabs -> replace tabs onSuccess"
      onFailure: () ->
        steroids.logger.log "repeatReplaceTabs -> replace tabs onFailure"


    steroids.tabBar.replace options, callBacks
