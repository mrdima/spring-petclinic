#!/bin/bash

DOCKER_HOST=minion1
BUILD_PATH=/tmp/appbuild
REPO="https://github.com/momerkic-abh/spring-petclinic.git"
BRANCH="mysql"

BUILD_IMAGE="momerkic/app-build:v2.2"
BUILD_CONTAINER="app-build"
DOCKERFILE="./Dockerfile.build"

# Clone repo
salt $DOCKER_HOST cmd.run "/bin/rm -rf $BUILD_PATH; \
  git clone  $REPO $BUILD_PATH && cd $BUILD_PATH; \
  git checkout $BRANCH "

# Create build container
salt $DOCKER_HOST cmd.run "docker rmi -f $BUILD_IMAGE; \
  docker rm -f $BUILD_CONTAINER; \
  cd $BUILD_PATH && docker build -t $BUILD_CONTAINER -f $DOCKERFILE . "