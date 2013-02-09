class window.SteroidsController

  @testSteroidsDefined: () ->
    alert steroids?

  @testOpenURLGoogle: () ->
    steroids.openURL {
      url: "http://www.google.com"
    }, {
      onSuccess: () -> alert "google opened externally"
      onFailure: () -> alert "failed to open google externally"
    }

  @testOpenURLMaps: () ->
    steroids.openURL {
      url: "maps://"
    }, {
      onSuccess: () -> alert "maps opened"
      onFailure: () -> alert "failed to open maps"
    }