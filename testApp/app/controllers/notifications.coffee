class window.NotificationsController

  @testHello: () ->
    steroids.notifications.post {
      message: "hello"
    }, {
      onSuccess: () -> notification "success"
      onFailure: () -> alert "failed"
    }
