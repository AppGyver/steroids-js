document.addEventListener "deviceready", ->
  Steroids.on "ready", ()=>
    oAuth2Configuration = {
      clientID: "kjhsdgfkasjdhfgaksjhdfgaksjdhfgaskdjhfgaskdjfhgaskdfjhgaskdf",
      clientSecret: "fdjsklahsdjkfalhsdkfjashfldkjashdflkasjdhfskjdskjdskjdskjdsddddd",
      callbackPath: "views/oauth/success.html",
      authorizationUrl: "http://accounts.appgyver.com/auth/appgyver_id/authorize",
      accessTokenUrl: "http://accounts.appgyver.com/auth/appgyver_id/access_token"
    }

    oauth = new Steroids.OAuth oAuth2Configuration

    authElement = document.getElementById("authenticate")
    fetchElement = document.getElementById("fetchJSON")

    if authElement?
      authElement.addEventListener "touchstart", ->
        oauth.authenticate()

    if fetchElement?
      fetchElement.addEventListener "touchstart", ->
        console.log localStorage.getItem("JESSE")

    if window.location.href.indexOf("success.html") >= 0
      oauth.finish (token)->
        localStorage.setItem "JESSE", token
        Steroids.modal.hide()
