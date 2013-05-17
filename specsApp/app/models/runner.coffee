
describe "steroids", ->

  it "should exists", ->
    expect( typeof steroids ).toBeDefined()


describe "steroids.Animation", ->

  it "should be defined", ->
    expect( steroids.Animation ).toBeDefined()

  it "should perform", ->
    animationPerformed = false

    animation = new steroids.Animation()
    animation.perform {},
      onSuccess: -> animationPerformed = true

    waitsFor -> animationPerformed

    runs ->
      expect( animationPerformed ).toBeTruthy()


  # TODO: bug in native
  xit "should fail to perform twice", ->

    performFailed = false

    animation = new steroids.Animation()
    animation.perform()

    animation2 = new steroids.Animation()
    animation2.perform {},
      onFailure: ->
        performFailed = true

    waitsFor ->
      performFailed

    runs ->
      expect( performFailed ).toBeTruthy()

describe "steroids.device", ->

  it "should be defined", ->
    expect( steroids.device ).toBeDefined()

  describe "ping", ->

    it "should pong", ->

      ponged = false

      steroids.device.ping {},
        onSuccess: -> ponged = true

      waitsFor -> ponged

      runs ->
        expect( ponged ).toBeTruthy()


  describe "torch", ->

    it "should toggle", ->
      toggled = false

      steroids.device.torch.toggle {},
        onSuccess: -> toggled = true

      waitsFor -> toggled

      runs ->
        expect( toggled ).toBeTruthy()

    it "should turn on", ->
      turnedOn = false

      steroids.device.torch.turnOn {},
        onSuccess: -> turnedOn = true

      waitsFor -> turnedOn

      runs ->
        expect( turnedOn ).toBeTruthy()

    it "should turn off", ->
      turnedOff = false

      steroids.device.torch.turnOff {},
        onSuccess: -> turnedOff = true

      waitsFor -> turnedOff

      runs ->
        expect( turnedOff ).toBeTruthy()


describe "steroids.layers", ->

  it "should be defined", ->
    expect( steroids.layers ).toBeDefined()

  it "should open a new layer", ->
    googleLayer = new steroids.views.WebView("http://google.com")
    pushed = false

    steroids.layers.push {
      view: googleLayer
    }, {
      onSuccess: -> pushed = true
    }

    waitsFor -> pushed

    runs ->
      expect( pushed ).toBeTruthy()
      setTimeout ->
        steroids.layers.pop()
      , 1000


describe "steroids.modal", ->

  # TODO: figure out a way to perform
  xit "should present", ->

    googleLayer = new steroids.views.WebView("http://google.com")
    presented = false

    steroids.modal.show {
      view: googleLayer
    }, {
      onSuccess: ->
        presented = true
    }

    waitsFor ->
      presented

    runs ->
      expect( presented ).toBeTruthy()


describe "steroids.view.navigationBar", ->

  # TODO: bug no success
  xit "should be shown", ->
    shown = false

    steroids.view.navigationBar.show {
      title: "Steroids!"
    }, {
      onSuccess: ->
        shown = true
    }

    waitsFor ->
      shown

    runs ->
      expect( shown ).toBeTruthy()

  describe "rightbutton", ->

    xit "should show button"


jasmineEnv = jasmine.getEnv()

jasmineEnv.updateInterval = 1000


htmlReporter = new jasmine.HtmlReporter()

jasmineEnv.addReporter(htmlReporter)

jasmineEnv.specFilter = (spec) =>
  return htmlReporter.specFilter(spec)

window.onload = () =>
  jasmineEnv.execute()
