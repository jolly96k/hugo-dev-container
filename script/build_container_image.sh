#! /usr/bin/env bash

set -euxo pipefail

DOCKER_PROJECT_PATH=$(cd $(dirname ${0}) && cd ../ && pwd)
HUGO_DIRECTORY_PATH=${DOCKER_PROJECT_PATH}/hugo

IMAGE_NAME=hugo-dev
IMAGE_TAG=latest

BUILD_ARG_HUGO_VERSION=0.120.3

cd ${DOCKER_PROJECT_PATH}

docker image build -t ${IMAGE_NAME}:${IMAGE_TAG} \
                   -f ${HUGO_DIRECTORY_PATH}/dockerfile ${HUGO_DIRECTORY_PATH} \
                   --progress plain \
                   --build-arg HUGO_VERSION=${BUILD_ARG_HUGO_VERSION}

docker system prune -f