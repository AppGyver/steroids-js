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

  @testSelectTab: ->
    steroids.tabBar.selectTab 1
