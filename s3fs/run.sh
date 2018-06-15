#!/bin/bash

if [[ -z "$FEEDS_DAT" ]]; then
    echo "Must provide FEEDS_DAT in environment" 1>&2
    exit 1
fi

if [[ -z "$S3ACCESSKEY" ]] || [[ -z "$S3SECRETKEY" ]]; then
    echo "Must provide S3ACCESSKEY and S3SECRETKEY in environment" 1>&2
    exit 1
fi

echo "$S3ACCESSKEY:$S3SECRETKEY" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs

mkdir /data
s3fs $S3BUCKET /data -o allow_other,default_acl=public-read -o url=https://s3.wasabisys.com -o passwd_file=~/.passwd-s3fs -o use_cache=/tmp

cd /data

ls

# Start the first process
dat clone $FEEDS_DAT feeds_dat && dat sync -d feeds_dat/ &
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
