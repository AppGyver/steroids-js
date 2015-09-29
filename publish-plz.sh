#!/usr/bin/env bash -x

# If you need to rollback due to error in this script:
# - git reset --hard origin/master
# - git tag --delete 3.5.XX
# - git push origin :3.5.XX
# - cd bower && git reset --hard origin/master

set -e

echo "Ready to publish?"
read okay

./bump-plz.sh

grunt

# ensure bower/
git submodule update --init

cd bower && git checkout master && cd ..

VERSION=$(coffee sync-bower.coffee)
echo "VERSION=$VERSION"

echo "Is the version number above correct?"
read maybe

cp dist/steroids.js bower/steroids.js
cd bower && git checkout master && git commit -am "$VERSION" && git tag "v$VERSION" && git push && git push --tags && cd ..
git add bower && git commit -m "Updated submodule to $VERSION" && git push && git push --tags

echo "Publishing to NPM"
npm publish ./
