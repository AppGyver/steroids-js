class NavigationBarButton
  constructor: (options={})->
    @title = options.title
    @onTap = options.onTap
    @imagePath = options.imagePath
    @imageAsOriginal = options.imageAsOriginal

  toParams: () ->
    params = {}
    if @title?
      params.title = @title
    else
      relativeTo = steroids.app.path
      params.imagePath = relativeTo + @imagePath
      
    params.imageAsOriginal = @imageAsOriginal
      
    return params

  getCallback: () ->
    if @onTap?
      return @onTap