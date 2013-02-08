class window.NavigationbarController

  @testHide: () ->
    steroids.view.navigationBar.hide {
    },{
      onSuccess: () -> alert "hided"
      onFailure: () -> alert "failed to hide"
    }

  @testShow: () ->
    steroids.view.navigationBar.show {
    },{
      onSuccess: () -> alert "showed"
      onFailure: () -> alert "failed to show"
    }

  @testShowWithTitle: () ->
    steroids.view.navigationBar.show {
      title: "Any title"
    },{
      onSuccess: () -> alert "showed with title"
      onFailure: () -> alert "failed to show with title"
    }
