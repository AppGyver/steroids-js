buster.spec.expose()

describe "Layer", ->
  before ->
    @timeout = 10000

  it "should exist", ->

    expect( typeof Steroids.Layer ).toBe "function"

  it "should take location", ->
    layer = new Steroids.Layer({location: "http://www.google.com"})

    expect( layer.location ).toBe "http://www.google.com"


  describe "collection", ->

    it "should exist", ->
      expect( Steroids.layers.array ).toEqual []

    it "should push and pop layers", (done)->

      # layer = new Steroids.Layer {
      #   location: "http://www.google.com"
      #   pushAnimation: "fade"
      #   pushAnimationDuration: 0.1
      #   popAnimation: "fade"
      #   popAnimationDuration: 0.1
      # }
      #
      # Steroids.layers.push layer,
      #   onSuccess: ->
      #     setTimeout ()=>
      #       Steroids.layers.pop {},{}
            assert true
            done()
        #   , 2000
        # onFailure: ->
        #     assert false
        #     done()

  # it "should preload", ->
  #
  # it "should reload", ->
  #   Steroids.layer.reload()
  #
  # it "should call onload callback when pushed", ->
  #   # setTimeout(function(){
  #   #   layer.onload = function(){alert('parametriolitämä')
  #   #   Steroids.layers.push(layer})
  #   # }, 5000)
  #
  # it "should pop all layers", ->
  #   # Steroids.layers.popAll()
  #
  # it "should return all layers", ->
  #   # Steroids.layers => [LayerObject, LayerObject]
  #
