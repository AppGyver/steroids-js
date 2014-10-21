describe "App", ->

  before (done)->
    steroids.on "ready", ->
      done()

  it "should be defined", ->
    steroids.app.should.be.defined

  describe "app.getLaunchURL", ->
    it "should be a function", ->
      steroids.app.getLaunchURL.should.be.a "function"

  describe "app.host.getURL", ->
    it "should be a function", ->
      steroids.app.host.getURL.should.be.a "function"

  describe "app.getMode", ->
    it "should be a function", ->
      steroids.app.getMode.should.be.a "function"

  describe "app.getNSUserDefaults", ->
    it "should be a function", ->
      steroids.app.getNSUserDefaults.should.be.a "function"


  describe "app.absoluteUserFilesPath", ->
    it "should be a string", ->
      steroids.app.absoluteUserFilesPath.should.be.a "string"

    platformName = null
    before (done) ->
      steroids.device.platform.getName {}, onSuccess: (name) ->
        platformName = name
        done()

    it "might be a file path", ->
      if platformName is "ios"
        steroids.app.absoluteUserFilesPath[0].should.equal "/"
        # should test better for "/var/mobile/Applications/AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA/Scanner.app/Documents"

      # needs test case for android


  describe "app.absolutePath", ->
    it "should be a string", ->
      steroids.app.absolutePath.should.be.a "string"



  # needs still tests with each platform and each mode to make sure that there are the actually right values in the paths and stuff

  # needs pixate load theme stuff