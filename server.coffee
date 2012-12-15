express = require "express"
path = require "path"
app = express()

app.use express.static( path.join( __dirname, "dist" ) )

app.listen(1337)