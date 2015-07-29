class NavigationBarButton
  constructor: (options={})->

    uuidPartOfSize = (length) ->
      uuidpart = ""
      for idx in [0 .. length]
        uuidchar = parseInt(Math.random() * 256, 10).toString 16
        uuidchar = if uuidchar.length == 1
          "0" + uuidchar
        uuidpart += uuidchar
      return uuidpart

    generateId = () ->
      "#{uuidPartOfSize 2}-#{uuidPartOfSize 4}-#{uuidPartOfSize 6}-#{uuidPartOfSize 2}"

    @title = options.title
    @onTap = options.onTap
    @imagePath = options.imagePath
    @imageAsOriginal = options.imageAsOriginal
    @styleClass = options.styleClass

    @id = options.id || options.styleId || generateId()
    @styleId = @id
    @styleCSS = options.styleCSS

  toParams: () ->
    params = {}
    if @title?
      params.title = @title
    else
      relativeTo = steroids.app.path
      params.imagePath = relativeTo + @imagePath

    params.imageAsOriginal = @imageAsOriginal
    params.styleClass = @styleClass
    params.styleId = @styleId
    params.styleCSS = @styleCSS

    return params

  getCallback: () ->
    if @onTap?
      return @onTap
