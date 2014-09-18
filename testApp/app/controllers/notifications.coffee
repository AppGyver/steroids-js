class window.NotificationsController

  @testHello: () ->
    steroids.notifications.post {
      message: "hello"
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in sending steroids notification"
      onFailure: () -> navigator.notification.alert "FAILURE in testHello in notifications"
    }
