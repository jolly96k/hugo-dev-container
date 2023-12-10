#! /usr/bin/env bash

set -euxo pipefail

DOCKER_PROJECT_PATH=$(cd $(dirname ${0}) && cd ../ && pwd)
HUGO_DIRECTORY_PATH=${DOCKER_PROJECT_PATH}/hugo

BUILD_ARG_HUGO_VERSION=0.120.3

cd ${HUGO_DIRECTORY_PATH}

docker image build --build-arg HUGO_VERSION=${BUILD_ARG_HUGO_VERSION} \
                   --progress plain \
                   -t hugo-dev .

docker system prune -f