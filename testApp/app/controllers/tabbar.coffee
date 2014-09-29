class window.TabbarController
  @index: ->

    # always put everything inside PhoneGap deviceready
    document.addEventListener "deviceready", ->

      # Make Navigation Bar to appear with a custom title text
      steroids.view.navigationBar.show { title: "tabbar" }

  @testSetStyleId_myLittleTab: ->
    steroids.tabBar.setStyleId "myLittleTab"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleId_myLittleTab"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleId_myLittleTab"

  @testRemoveStyleId: ->
    steroids.tabBar.setStyleId ""
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testRemoveStyleId"
      onFailure: -> navigator.notification.alert "FAILURE in testRemoveStyleId"

  @testSetStyleClass_tabGray: ->
    steroids.tabBar.setStyleClass "tabGray"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleClass_tabGray"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleClass_tabGray"

  @testSetStyleCSS: ->
    steroids.tabBar.setStyleCSS "border: 2px solid #FFCF40;"
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testSetStyleCSS"
      onFailure: -> navigator.notification.alert "FAILURE in testSetStyleCSS"

  @testUpdateTabItemsWithStyle: ->
    steroids.tabBar.update
      tabs: [
          {
            styleClass: "tab-bar-item-yellow"
          },
          {
            styleId: "second-item"
          },
          {
            styleCSS: "color:red;"
          }
        ]
    ,
      onSuccess: -> steroids.logger.log "SUCCESS in testUpdateTabItemsWithStyle"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdateTabItemsWithStyle"

  @testHide: ->
    steroids.tabBar.hide {},
      onSuccess: -> steroids.logger.log "SUCCESS in hiding the tab bar"
      onFailure: -> navigator.notification.alert "FAILURE in testHide tab bar"

  @testShow: ->
    steroids.tabBar.show {},
      onSuccess: -> steroids.logger.log "SUCCESS in showing the tab bar"
      onFailure: -> navigator.notification.alert "FAILURE in testShow tab bar"

  @testUpdateTop: ->
    steroids.tabBar.update {
      position: 'top'
    },
    onSuccess: -> steroids.logger.log "SUCCESS in testUpdateTop updating tab bar to be on the top"
    onFailure: -> navigator.notification.alert "FAILURE in testUpdateTop tab bar"

  @testUpdateBottom: ->
    steroids.tabBar.update {
      position: 'bottom'
    },
    onSuccess: -> steroids.logger.log "SUCCESS in testUpdateBottom updating tab bar to be on the bottom"
    onFailure: -> navigator.notification.alert "FAILURE in testUpdateBottom tab bar"


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
      onSuccess: -> steroids.logger.log "SUCCESS in updating tab bar with different icons, titles and badges"
      onFailure: -> navigator.notification.alert "FAILURE in testUpdate tab bar with different titles, icons and badges"
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
      onSuccess: -> steroids.logger.log "SUCCESS in resetBadges tab bar"
      onFailure: -> navigator.notification.alert "FAILURE in resetBadges tab bar"
    )

  @testSelectTab: ->
    steroids.tabBar.selectTab 1,
      onSuccess: -> steroids.logger.log "SUCCESS in selecting 1st tab"
      onFailure: -> navigator.notification.alert "FAILURE in testSelectTab"

  @testUpdateTab: ->
    steroids.tabBar.currentTab.update({
      title: "New Title"
      image_path: "icons/shoebox@2x.png"
      badge: "1"
    },
    onSuccess: ->
      steroids.logger.log "SUCCESS updating curent tab"
    onFailure: (failure) ->
      steroids.logger.log "FAILURE in testUpdateTab - current tab: ", failure
      navigator.notification.alert "FAILURE in testUpdateTab - updating current tab"
    )

  @willChangeHandlers = []
  @didChangeHandlers = []

  @testwillchangeEvent: ->
    eventHandler = steroids.tabBar.on 'willchange', (event) ->
      steroids.logger.log "SUCCESS willchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @willChangeHandlers.push eventHandler

    steroids.logger.log "willchange event listener added"

  @testdidchangeEvent: ->
    eventHandler = steroids.tabBar.on 'didchange', (event) ->
      steroids.logger.log "SUCCESS didchange event -> eventName: #{event.name} target.tab title - index: #{event.target.tab.title} - #{event.target.tab.index} \n source.tab title - index: #{event.source.tab.title} - #{event.source.tab.index}"

    @didChangeHandlers.push eventHandler

    steroids.logger.log "didchange event listener added"

  @testRemoveAllEventHandlers: ->
    @didChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'didchange', handlerId

    @willChangeHandlers.forEach (handlerId) -> steroids.tabBar.off 'willchange', handlerId

    @willChangeHandlers = []
    @didChangeHandlers = []

    steroids.logger.log "event handlers removed"

  @testRemoveDidChangeEvents: ->
    steroids.tabBar.off 'didchange'

    steroids.logger.log "didchange events handlers removed"

  @testRemoveWillChangeEvents: ->
    steroids.tabBar.off 'willchange'

    steroids.logger.log "willchange events handlers removed"

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
        steroids.logger.log "SUCCESS in replacing tabs to inverted"
      onFailure: () ->
        navigator.notification.alert "FAILURE in testReplaceTabsInvertedOrder"


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
        steroids.logger.log "SUCCESS in replacing tabs back to original"
      onFailure: () ->
        navigator.notification.alert "FAILURE in testReplaceTabsOriginalOrder"


    steroids.tabBar.replace options, callBacks

  @testReplaceTabsNoParams: ->
    callBacks =
      onSuccess: () ->
        steroids.logger.log "SUCCESS in replacing tabs with no params (no change should be detected)"
      onFailure: () ->
        navigator.notification.alert "FAILURE in testReplaceTabsNoParams (nothing should have changed)"

    steroids.tabBar.replace null, callBacks

  @replaceTabsIntervalId = 0;

  @repeatReplaceTabs: ->
    steroids.logger.log "TEST repeatReplaceTabs -> will call replaceTabs in 2 seconds."
    setInterval ()->
      steroids.logger.log "TEST repeatReplaceTabs -> calling replaceTabs ... "
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
        steroids.logger.log "SUCCESS in repeatReplaceTabs"
      onFailure: () ->
        steroids.logger.log "FAILURE in repeatReplaceTabs"


    steroids.tabBar.replace options, callBacks
