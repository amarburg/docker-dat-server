#!/bin/bash

cd /data

if [[ -z "$FEEDS_DAT" ]]; then
    echo "Must provide FEEDS_DAT in environment" 1>&2
    exit 1
fi

# Start the first process
dat clone $FEEDS_DAT feeds_dat
dat sync -d feeds_dat/ &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

FEEDS_PATH=/data/feeds_dat/${FEEDS_FILE:-feeds}

echo "Using feeds file $FEEDS_PATH"

rm -f feeds
ln -s $FEEDS_PATH feeds

# Start the second process
hypercored
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi
