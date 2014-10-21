describe "App", ->

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
      steroids.app.userFilesPath.should.be.a "string"

  describe "app.absolutePath", ->
    it "should be a string", ->
      steroids.app.absolutePath.should.be.a "string"

  # needs still tests with each platform and each mode to make sure that there are the actually right values in the paths and stuff