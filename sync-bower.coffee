fs = require "fs"
componentJSONPath = "./bower/component.json"

packageJSON = require "./package.json"
currentVersion = packageJSON.version

componentJSON = require componentJSONPath
componentJSON.version = currentVersion

fs.writeFileSync componentJSONPath, JSON.stringify(componentJSON, null, "\t")
