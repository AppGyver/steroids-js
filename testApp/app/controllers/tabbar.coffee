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

  @testReplace: ->
    steroids.tabBar.replace({
      tabs:
        [
          {
            title: "TabBar"
            icon: "icons/telescope@2x.png"
            location: "http://localhost:13101/views/tabbar/index.html"
          },
          {
            title: "Index"
            icon: "icons/pill@2x.png"
            location: "http://localhost:13101/views/steroids/index.html"
          }
        ]
      },
      onSuccess: -> alert "replaced"
      onFailure: -> alert "failed to replace"
    )

  @testUpdate: ->
    steroids.tabBar.update({
      tabs:
        [
          {
            title: "Tabbar2"
            icon: "icons/pill@2x.png"
          },
          {
            title: "Index2"
            icon: "icons/telescope@2x.png"
          }
        ]
      },
      onSuccess: -> alert "updated"
      onFailure: -> alert "failed to update"
    )
