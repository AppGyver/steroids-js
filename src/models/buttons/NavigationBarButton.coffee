class NavigationBarButton
  constructor: (options={})->
    @title = options.title
    @onTap = options.onTap
    @imagePath = options.imagePath

  toParams: () ->
    params = {}
    if @title?
      params.title = @title
    else
      relativeTo = steroids.app.path
      params.imagePath = relativeTo + @imagePath
    return params

  getCallback: () ->
    if @onTap?
      return @onTap