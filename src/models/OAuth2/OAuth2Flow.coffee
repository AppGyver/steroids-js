class OAuth2Flow
  constructor: (@options)->
    @options.callbackUrl = "http://localhost:13101/#{@options.callbackPath}"

  authenticate: ()->
    throw "ERROR: #{@name} has not overridden authenticate method"

  concatenateUrlParams: (params)->
    first = true
    result = ""

    for key, value of params
      if first
        result = result.concat "?"
        first = false
      else
        result = result.concat "&"

      result = result.concat "#{key}=#{encodeURIComponent(value)}"

    return result

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
