#!/bin/bash

REPO_NAME=radpenguin/xteve
BUILD_DATE=$(date +"%Y-%m-%d-%H-%M-%S")
VERSION=1.0.0
scriptStartTime=$( date +%s )

options=
isReleaseVersion=0
if [[ -z "$1" ]]; then
  isReleaseVersion=1
  options="--no-cache \
  --build-arg=BUILD_DATE=\"$BUILD_DATE\" \
  --build-arg=VERSION=\"$VERSION\""

  echo "Building release version"
else
  echo "Building non-release version"
fi
sleep 2

set -e -u

docker build \
  $options \
  --tag=$REPO_NAME \
  .

if [[ $isReleaseVersion -eq 1 ]]; then
  docker push $REPO_NAME
fi

scriptEndTime=$( date +%s )
echo "Completed build in "$((scriptEndTime-$scriptStartTime))" seconds"
