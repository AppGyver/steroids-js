class window.NotificationsController

  @testHello: () ->
    steroids.notifications.post {
      message: "hello"
    }, {
      onSuccess: () -> alert "success"
      onFailure: () -> alert "failed"
    }
