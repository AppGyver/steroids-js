Steroids JS - html5 wrapper JS unfucked
---------------------------------------


## Development:

  npm install

and for docs

  easy_install pygments


## Publishing:

    grunt
    git submodule update  # ensure bower/

    sh ./bumb-plz.sh
    echo "VERSION=$(coffee sync-bower.coffee)"

    cp dist/steroids.js bower/steroids.js
    cd bower && git co master && git commit -am "$VERSION" && git tag "v$VERSION" && git push && git push --tags && cd ..
    git add bower && git commit -m "Updated submodule to $VERSION" && git push && git push --tags

    npm publish ./


## Testing:

First, remember to GRUNT

  grunt

becase this inserts your IP to testSlave/www/index.html (and creates that file)

To start buster server

  npm start

connect real clients

  cd testSlave && steroids connect

then, run tests

  npm test

and to shut down buster

  npm stop


### automatically restart buster server and run tests (because it loses connections quite frequently)

  npm testloop

## Generate Docs:
  Grunt default task takes care of generating the docs.
