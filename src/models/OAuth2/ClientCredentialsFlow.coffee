class ClientCredentialsFlow extends OAuth2Flow
  authenticate: (callback)->
    @xhrAccessTokenParams =
      client_id: @options.clientID
      client_secret: @options.clientSecret
      scope: @options.scope || ""
      grant_type: "client_credentials"

    request = new XMLHttpRequest()

    request.open("POST", @options.accessTokenUrl)

    body = []

    for key,value of @xhrAccessTokenParams
      body.push "#{key}=#{@urlEncode(value)}"

    body = body.sort().join('&');

    request.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"

    request.onreadystatechange = ()=>
      if request.readyState == 4
        responseJSON = JSON.parse(request.responseText)

        callback(responseJSON.access_token)

    request.send(body)
