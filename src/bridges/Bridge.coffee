class Bridge
  constructor: ->

  send: (options)->
    throw "ERROR: Bridge.send not overridden by subclass!"
