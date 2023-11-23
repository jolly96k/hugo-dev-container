#! /usr/bin/env bash

set -euxo pipefail

SCRIPT_DIRNAME=$(cd $(dirname ${0}) && pwd)
DOCKER_PROJECT_PATH=$(cd $(dirname ${0}) && cd ../ && pwd)

cd ${DOCKER_PROJECT_PATH}

docker image build -t hugo-dev . \
                   --progress plain \
                   --build-arg HUGO_VERSION=0.120.3

docker system prune -f