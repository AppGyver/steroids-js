#!/bin/bash
# just call with ./kill-server buster-server|phantom

function get_buster_server_pid(){
    echo `ps aux|grep [b]uster-server|grep node|awk '{ print $2 }'`
}

function get_phantom_server_pid(){
    echo `ps aux|grep [p]hantomjs|head -1|awk '{ print $2 }'`
}

BUSTER=$(get_buster_server_pid)
PHANTOM=$(get_phantom_server_pid)

echo $BUSTER
echo $PHANTOM

if [[ ! "$BUSTER" == "" ]]; then
  echo "KILLING BUSTER"
  kill -9 $BUSTER
fi

if [[ ! "$PHANTOM" == "" ]]; then
  echo "KILLING PHANTOM"
  kill $PHANTOM
fi
