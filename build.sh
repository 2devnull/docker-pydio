#!/bin/bash
# set -e
# set -x


CONTAINER='2devnull/docker-pydio'

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist. Building......"
  docker build -t $CONTAINER .
  exit 0
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running. Removing....."
  docker rm -f $CONTAINER
  echo "Building......"
  docker build -t $CONTAINER .
  exit 0
fi

GHOST=$(docker inspect --format="{{ .State.Ghost }}" $CONTAINER)

if [ "$GHOST" == "true" ]; then
  echo "WARNING - $CONTAINER has been ghosted."
  exit 1
fi

STARTED=$(docker inspect --format="{{ .State.StartedAt }}" $CONTAINER)
NETWORK=$(docker inspect --format="{{ .NetworkSettings.IPAddress }}" $CONTAINER)
echo "OK - $CONTAINER is running. IP: $NETWORK, StartedAt: $STARTED"
echo "Stopping, Removing, Building........"


docker stop $CONTAINER
docker rm -f $CONTAINER
docker build -t $CONTAINER .

