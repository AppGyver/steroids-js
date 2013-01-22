class AuthorizationCodeFlow extends OAuth2Flow

  authenticate: ()=>
    @xhrAuthorizationParams =
      response_type: "code"
      client_id: @options.clientID
      redirect_uri: @options.callbackUrl
      scope: @options.scope || ""

    authorizationUrl = @options.authorizationUrl.concat @concatenateUrlParams(@xhrAuthorizationParams)

    authenticationLayer = new Steroids.Layer { location: authorizationUrl }
    Steroids.modal.show({ layer: authenticationLayer })

  finish: (callback)=>
    @xhrAccessTokenParams =
      client_id: @options.clientID
      client_secret: @options.clientSecret
      redirect_uri: @callbackUrl
      grant_type: "authorization_code"

    request = new XMLHttpRequest()

    request.open("POST", @options.accessTokenUrl)

    body = []

    for key,value of @xhrAccessTokenParams
      body.push "#{key}=#{@urlEncode(value)}"

    body.push("code=#{Steroids.layer.params['code']}")

    body = body.sort().join('&');

    request.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"

    request.onreadystatechange = ()=>
      if request.readyState == 4
        responseJSON = JSON.parse(request.responseText)

        callback(responseJSON.access_token)

        # hide authenticationLayer
        Steroids.modal.hide()

    request.send(body)
