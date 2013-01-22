# Acually OAuth2
class OAuth

  constructor: (@options)->
    @callbackUrl = "http://localhost:13101/#{@options.callbackPath}"

    @xhrAuthorizationParams =
      response_type: "code"
      client_id: @options.clientID
      redirect_uri: @callbackUrl
      scope: ""

    @xhrAccessTokenParams =
      client_id: @options.clientID
      client_secret: @options.clientSecret
      redirect_uri: @callbackUrl
      grant_type: "authorization_code"

  authenticate: ()=>
    authorizationUrl = @options.authorizationUrl
    first = true
    console.log "EKAIN"
    console.log @xhrAuthorizationParams
    for key, value of @xhrAuthorizationParams
      console.log key
      console.log value
      if first
        authorizationUrl = authorizationUrl.concat "?"
        first = false
      else
        authorizationUrl = authorizationUrl.concat "&"

      authorizationUrl = authorizationUrl.concat "#{key}=#{encodeURIComponent(value)}"

    console.log "EKA"
    console.log authorizationUrl
    window.location.href = authorizationUrl
    # authenticationLayer = new Steroids.Layer { location: authorizationUrl }
    # Steroids.modal.show({ layer: authenticationLayer })

  finish: (callback)=>
    request = new XMLHttpRequest()

    request.open("POST", @options.accessTokenUrl)

    body = []
    for key,value of @xhrAccessTokenParams
      body.push(@urlEncode(key) + '=' + @urlEncode(value + ''))

    body.push("code=#{Steroids.layer.params['code']}")

    console.log body
    body = body.sort().join('&');

    console.log body

    request.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    # request.setRequestHeader 'X-Requested-With','XMLHttpRequest'

    request.onreadystatechange = ()=>
      if request.readyState == 4
        console.log request.status
        console.log request.responseText

        responseJSON = JSON.parse(request.responseText)
        callback(responseJSON.access_token)


    request.send(body)

  urlEncode: (string)->
    hex = (code) ->
      result = code.toString(16).toUpperCase()
      result = 0 + result  if result.length < 2
      "%" + result

    return ""  unless string

    string = string + ""
    reserved_chars = /[ \r\n!*"'();:@&=+$,\/?%#\[\]<>{}|`^\\\u0080-\uffff]/
    str_len = string.length
    i = undefined
    string_arr = string.split("")
    c = undefined
    i = 0

    while i < str_len
      if c = string_arr[i].match(reserved_chars)
        c = c[0].charCodeAt(0)
        if c < 128
          string_arr[i] = hex(c)
        else if c < 2048
          string_arr[i] = hex(192 + (c >> 6)) + hex(128 + (c & 63))
        else if c < 65536
          string_arr[i] = hex(224 + (c >> 12)) + hex(128 + ((c >> 6) & 63)) + hex(128 + (c & 63))
        else string_arr[i] = hex(240 + (c >> 18)) + hex(128 + ((c >> 12) & 63)) + hex(128 + ((c >> 6) & 63)) + hex(128 + (c & 63))  if c < 2097152
      i++
    string_arr.join ""
