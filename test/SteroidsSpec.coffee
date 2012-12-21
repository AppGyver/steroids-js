buster.spec.expose()

describe "Steroids namespace", ->
  it "should exist", ->
    expect( typeof Steroids ).toBe "function"

  it "should have version number 0.0.1", ->
    expect( Steroids.version ).toBe "0.0.1"

  # it "should have a ready event", (done)->
  #   expect( typeof Steroids.on ).toBe "function"
  #
  #   Steroids.on "ready", ()=>
  #     assert true
  #     done()
