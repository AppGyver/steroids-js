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

  #it "should restart", (done)->

    #@send "startApplication",
    #  parameters:
    #    id: @application_json.id
    #    name: @application_json.name
    #    path: @application_json.application_path
    #    server_host: URI(@json_url).hostname()
    #    server_port: ( URI(@json_url).port() || "80" )
    #    bottom_bars:  @application_json.bottom_bars
    #    configuration: @application_json.configuration
    #    appearance: @application_json.appearance
    #    authentication: @application_json.authentication
    #    update: @application_json.update