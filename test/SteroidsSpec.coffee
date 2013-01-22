buster.spec.expose()

describe "Steroids namespace", ->
  it "should exist", ->
    expect( typeof Steroids ).toBe "function"

  it "should have version number", ->
    expect( Steroids.version ).toBe "0.1.7"

  # it "should have a ready event", (done)->
  #   expect( typeof Steroids.on ).toBe "function"
  #
  #   Steroids.on "ready", ()=>
  #     assert true
  #     done()
