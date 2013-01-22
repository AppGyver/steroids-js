Steroids JS - html5 wrapper JS unfucked
---------------------------------------


## Development:

  npm install

and for docs

  easy_install pygments

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