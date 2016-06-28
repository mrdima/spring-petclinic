#!/bin/bash

DOCKER_HOST=minion1
BUILD_PATH=/tmp/appbuild
REPO="https://github.com/momerkic-abh/spring-petclinic.git"
BRANCH="mysql"

BUILD_IMAGE="momerkic/app-build:v2.2"
BUILD_CONTAINER="app-build"
BUILD_DOCKERFILE="./Dockerfile.build"

APP_IMAGE="momerkic/app-web:v2.2"
APP_CONTAINER="app-web"
#APP_DOCKERFILE="./Dockerfile"

# Clone repo
salt $DOCKER_HOST cmd.run "/bin/rm -rf $BUILD_PATH; \
  git clone  $REPO $BUILD_PATH && cd $BUILD_PATH; \
  git checkout $BRANCH "

# Create build container
salt $DOCKER_HOST cmd.run "docker rmi -f $BUILD_IMAGE; \
  docker rm -f $BUILD_CONTAINER; \
  cd $BUILD_PATH && docker build -t $BUILD_IMAGE -f $BUILD_DOCKERFILE . "

# Copy war
salt $DOCKER_HOST cmd.run "docker create --name $BUILD_CONTAINER $BUILD_IMAGE; \
  cd $BUILD_PATH && docker cp $BUILD_CONTAINER:/tmp/app-build/target/petclinic.war . ; \
  docker rm -f $BUILD_CONTAINER "

# Create/push app image
salt $DOCKER_HOST cmd.run "docker rmi -f $APP_IMAGE; \
  docker rm -f $APP_CONTAINER; \
  cd $BUILD_PATH && docker build -t $APP_IMAGE . && docker push $APP_IMAGE "
