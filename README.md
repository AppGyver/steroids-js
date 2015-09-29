# Steroids.js

A JavaScript library to be used with [AppGyver Steroids](http://appgyver.com/steroids) and [Steroids npm](//github.com/AppGyver/steroids). Steroids.js requires AppGyver Scanner application (available in Apple App Store and Google Play Store) or custom Scanner build from AppGyver Build Service.

## Development:

Setup Steroids project "testApp":

    1) npm install
    2) npm install -g grunt-cli
    3) grunt
    4) cd testApp && npm install

NOTE!
  You may need to manually run "grunt" before reloading Steroids in testApp!


## Testing

### Running the Automated Testsuite

There is a Jasmine test project in specsApp/ that has steroids.js symlinked from dist/

    1) Setup dependencies defined above under "Development"
    2) cd testSpecApp
    3) steroids connect

### Running the Manual Testsuite

There is a Steroids project for manual testing under testApp/ that has steroids.js symlinked from dist/

    1) Setup dependencies defined above under "Development"
    2) cd testApp
    3) steroids connect

## Bower distribution

Due to Bower limitations (cannot exclude certain files from a repository), the Bower distribution of Steroids.js resides in a different GitHub repository (https://github.com/steroidsjs/steroids-js) and is included as a submodule. Thus, to update the Bower distribution, you need GitHub access to the steroidsjs organization too.

## Publishing:

Execute:
./publish-plz.sh

## License

Steroids.js is released under the [MIT License](http://www.opensource.org/licenses/MIT).
