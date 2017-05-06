#!/bin/bash

mkdir -p mongodbtest
mongod --dbpath mongodbtest >/dev/null &
mongopid=$!
echo "mongod started with pid: $mongopid"

function ctrl_c() {
    echo "shutting down database"
    kill -15 $mongopid 2>/dev/null

    rm -rf mongodbtest
    exit 0
}
trap ctrl_c INT

echo "ready to test... press ctrl-c to quit"
# wait forever
cat
