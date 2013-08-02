class RSS
  constructor: (@options={}) ->
    @url = if options.constructor.name == "String"
      options
    else
      options.url

    throw "URL required" unless @url
