class Keyboard extends EventsSupport

  constructor: (options={})->
    #setup the events support
    super "keyboard_", ["actionButtonPressed"]
