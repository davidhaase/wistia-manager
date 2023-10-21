#!/bin/sh

# @(#)status.sh	0.1.0	21/OCT/2023
#
# @author       David Haase (hat tip to Jonathan Parker)
# @since        0.1.0
# @version      0.1.0
# 
# Usage:
#       status.sh

# Turn off color coding in grep for macOS

export GREP_OPTIONS=

# LOCAL PATHS
# Load the local paths
APP_HOME=${HOME}/Documents/Repositories/media-manager

# PID and .PID FILE
# If the program spun up correctly in the start.sh script, 
# ...then, a .PID file was created with a single value: the PID
if [ -f ${APP_HOME}/run/.pid ];then
  PID=$(cat ${APP_HOME}/run/.pid)
  PROC=$(/bin/ps auwwwx|grep -w "${PID}"|grep -v grep|awk '{print $2}')

  if [ -z "${PROC}" ];then
    echo "media-manager is not running as process ${PID}; the PID file must be stale"
  else
    if [ "${PID}" = "${PROC}" ];then
      echo "media-manager is running as process ${PID}."
    else
      echo "The status of media-manager is indeterminate."
    fi
  fi
else
  echo "No PID file found; media-manager is probably not running."
fi
