document.addEventListener "deviceready", ->
  Steroids.on "ready", ()=>
    Steroids.navigationBar.show { title: "OAUTH2" }


    authElement = document.getElementById("authenticate")
    fetchElement = document.getElementById("fetchJSON")
    clientCredsElement = document.getElementById("authClientCredentials")

    oAuth2Configuration = {
      clientID: "kjhsdgfkasjdhfgaksjhdfgaksjdhfgaskdjhfgaskdjfhgaskdfjhgaskdf",
      clientSecret: "fdjsklahsdjkfalhsdkfjashfldkjashdflkasjdhfskjdskjdskjdskjdsddddd",
      callbackPath: "views/oauth/success.html",
      authorizationUrl: "http://accounts.appgyver.com/auth/appgyver_id/authorize",
      accessTokenUrl: "http://accounts.appgyver.com/auth/appgyver_id/access_token"
    }

    oauth = new Steroids.OAuth2.AuthorizationCodeFlow oAuth2Configuration

    if authElement?
      authElement.addEventListener "touchstart", ->
        oauth.authenticate()

    if fetchElement?
      fetchElement.addEventListener "touchstart", ->
        console.log localStorage.getItem("JESSE")

    if window.location.href.indexOf("success.html") >= 0
      oauth.finish (token)->
        localStorage.setItem "JESSE", token

    if clientCredsElement?
      clientCredsElement.addEventListener "touchstart", ->
        oAuth2Configuration = {
          clientID: "kjhsdgfkasjdhfgaksjhdfgaksjdhfgaskdjhfgaskdjfhgaskdfjhgaskdf",
          clientSecret: "fdjsklahsdjkfalhsdkfjashfldkjashdflkasjdhfskjdskjdskjdskjdsddddd",
          callbackPath: "views/oauth/success.html",
          authorizationUrl: "http://accounts.appgyver.com/auth/appgyver_id/authorize",
          accessTokenUrl: "http://accounts.appgyver.com/auth/appgyver_id/access_token"
        }

        oauth = new Steroids.OAuth2.ClientCredentialsFlow oAuth2Configuration

        oauth.authenticate (token)->
          localStorage.setItem "TAPSA", token
