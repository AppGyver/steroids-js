buster.spec.expose()

describe "app", ->
  it "should exist", ->

    expect( typeof Steroids.app ).toBe "object"

  # it "should have path", (done)->
  #   Steroids.on 'ready', ()=>
  #     assert( /^\/var/.test Steroids.app.absolutePath )
  #     assert( /^applications/.test Steroids.app.path )
  #     done()