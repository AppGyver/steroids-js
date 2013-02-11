#!/bin/sh

DEFAULTSEVERITY=patch
SEVERITY=${1:-$DEFAULTSEVERITY}

npm version $SEVERITY && git push && git push --tags && npm publish ./
