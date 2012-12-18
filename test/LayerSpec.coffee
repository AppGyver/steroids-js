buster.spec.expose()

describe "Layer", ->
  before ->
    this.timeout = 3000

  it "should exist", ->

    expect( typeof Steroids.Layer ).toBe "function"

  it "should take location", ->
    layer = new Steroids.Layer({location: "http://www.google.com"})

    expect( layer.location ).toBe "http://www.google.com"


  describe "collection", ->

    it "should exist", ->
      expect( Steroids.layers instanceof LayerCollection ).toBe true

    it "should push and pop layers", (done)->

      layer = new Steroids.Layer({location: "http://www.google.com"})

      Steroids.layers.push(layer, {
        onSuccess: ->
          Steroids.layers.pop
            onSuccess: ->
              done()
      })



    it "// should have an instance in Steroids.layer", ->
      expect( Steroids.layer ).toBe "object"

###
#  it "should preload", ->

#  it "should reload", ->
#    Steroids.layer.reload()

  it "should call onload callback when pushed", ->
    # setTimeout(function(){
    #   layer.onload = function(){alert('parametriolitämä')
    #   Steroids.layers.push(layer})
    # }, 5000)




    it "should pop all layers", ->
      # Steroids.layers.popAll()

    it "should return all layers", ->
      # Steroids.layers => [LayerObject, LayerObject]
###




