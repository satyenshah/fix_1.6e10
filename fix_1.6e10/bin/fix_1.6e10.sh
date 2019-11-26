#!/bin/bash

# chmod a+x <this file> before deployment

# script changes epoch time match in etc/datetime.xml
# matches it to 1600000000 which flips in 2020-09-13
# restarts splunk
# tested on RHEL7 and Solaris11

# set localization from international for grep
LC_ALL="C"

if [ "$SPLUNK_HOME"  = "" ]; then
 SPLUNK_HOME="/opt/splunkforwarder"
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
DATETIMEXML="$SPLUNK_HOME/etc/datetime.xml"
DATETIMENEW="$SCRIPTPATH/../static/datetime.xml"
REBOOTFLAG=false

EPOCHMATCHOLD=':1\[012345\]|9'

if (grep -q $EPOCHMATCHOLD $DATETIMEXML) ; then
 /bin/cp -f $DATETIMENEW $DATETIMEXML
 if (!(grep -q $EPOCHMATCHOLD $DATETIMEXML)) ; then
  REBOOTFLAG=true
 fi
fi

if $REBOOTFLAG && [ "$(uname -s)" = "Linux" ]; then

  (exec setsid sh $SCRIPTPATH/restart_splunk.sh &)

elif $REBOOTFLAG && [ "$(uname -s)" = "SunOS" ]; then

  (exec sh $SCRIPTPATH/restart_splunk.sh &)

fi
