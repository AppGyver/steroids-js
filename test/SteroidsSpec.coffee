buster.spec.expose()

describe "Steroids namespace", ->
  it "should exist", ->
    expect( typeof Steroids ).toBe "function"

  it "should have version number 0.0.1", ->
    expect( Steroids.version ).toBe "0.0.1"
