#!/bin/bash

DOCKER_HOST=minion1
BUILD_PATH=/tmp/appbuild
REPO=https://github.com/momerkic-abh/spring-petclinic.git
BRANCH=mysql

salt $DOCKER_HOST cmd.run "/bin/rm -rf $BUILD_PATH; \
  git clone  $REPO $BUILD_PATH && cd $BUILD_PATH; \
  git checkout $BRANCH"