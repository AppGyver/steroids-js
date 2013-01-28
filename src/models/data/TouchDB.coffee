class TouchDB
  @baseURL: "http://.touchdb."

  constructor: (@options) ->
    throw "Database name required" unless @options.name

    @replicas = {}
    @baseURL = "#{TouchDB.baseURL}/#{@options.name}"


  startMonitoringChanges: (options={}, callbacks={}) ->
    request = new XMLHttpRequest();
    request.open("GET", "#{@baseURL}/_changes?feed=continuous")

    request.onreadystatechange = () =>
      return unless request.readyState == 3

      callbacks.onChange()

    request.send()

  createDB: (options={}, callbacks={}) ->
    request = new XMLHttpRequest();
    request.open("PUT", "#{@baseURL}/")

    request.onreadystatechange = () =>
      return unless request.readyState == 4

      if request.status == 412
        errorObj = JSON.parse(request.responseText)
        callbacks.onFailure(errorObj) if callbacks.onFailure

      if request.status == 201
        responseObj = JSON.parse(request.responseText)
        callbacks.onSuccess(responseObj) if callbacks.onSuccess

    request.send()


  addTwoWayReplica: (options={}, callbacks={}) ->

    toCloudAdded = ()=>
      @startReplication({source: options.url, target: @options.name}, {onSuccess: fromCloudAdded, onFailure: fromCloudFailed})

    toCloudFailed = ()=>
      callbacks.onFailure() if callbacks.onFailure

    fromCloudAdded = ()=>
      @replicas[options.url] = {}
      callbacks.onSuccess() if callbacks.onSuccess

    fromCloudFailed = ()=>
      callbacks.onFailure() if callbacks.onFailure


    @startReplication({source: @options.name, target: options.url}, {onSuccess: toCloudAdded, onFailure: toCloudFailed})


  startReplication: (options={}, callbacks={}) ->
    request = new XMLHttpRequest();
    request.open("POST", "#{TouchDB.baseURL}/_replicate")

    request.onreadystatechange = () =>
      return unless request.readyState == 4

      if request.status == 412
        errorObj = JSON.parse(request.responseText)
        callbacks.onFailure(errorObj)

      if request.status == 200
        responseObj = JSON.parse(request.responseText)


        callbacks.onSuccess.call(responseObj)


    request.send JSON.stringify({source: options.source, target: options.target, continuous: true})
