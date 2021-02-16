#!/bin/sh

SWANCTL="/usr/local/sbin/swanctl"

logmsg(){
  logger $@
}

connect(){
  $SWANCTL --initiate --child "$1"
}

main(){
  $SWANCTL -L | grep '^con' | cut -d: -f1 | while read con
  do
    if $SWANCTL -l | grep -q "^$con"
    then
      #logmsg "$con ALREADY CONNECTED"
      pass
    else
      logmsg "$con NOT CONNECTED. Initiating connection..."
      connect "$con"
    fi
  done
}

main
