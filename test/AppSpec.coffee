buster.spec.expose()

describe "app", ->
  it "should exist", ->

    expect( typeof Steroids.app ).toBe "object"

  it "should get path", (done)->

    Steroids.app.path {},
      onSuccess: (parameters)->
        assert( /^\/var/.test parameters.applicationFullPath )
        assert( /^applications/.test parameters.applicationPath )
        done()

      onFailure: ->
        assert false
        done()
