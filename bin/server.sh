#!/bin/bash

buster-server & # fork to a subshell
sleep 2 # takes a while for buster server to start
phantomjs ./bin/phantom.js &