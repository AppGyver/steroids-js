Steroids JS - html5 wrapper JS unfucked
---------------------------------------


## Development:

  npm install

## Publishing:

    sh ./bumb-plz.sh

    grunt
    git submodule update  # ensure bower/

    cd bower && git co master && cd ..

    echo "VERSION=$(coffee sync-bower.coffee)"

    cp dist/steroids.js bower/steroids.js
    cd bower && git co master && git commit -am "$VERSION" && git tag "v$VERSION" && git push && git push --tags && cd ..
    git add bower && git commit -m "Updated submodule to $VERSION" && git push && git push --tags

    npm publish ./


## Testing

### Automated

There is a jasmine test project in specsApp/ that has steroids.js symlinked from dist/

### Explorative

There is a separate steroids project in testApp/ that has steroids.js symlinked from dist/

## License

Steroids.js is released under the [MIT License](http://www.opensource.org/licenses/MIT).
