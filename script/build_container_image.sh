#! /usr/bin/env bash

set -euxo pipefail

SCRIPT_DIRNAME=$(cd $(dirname ${0}) && pwd)
DOCKER_PROJECT_PATH=$(cd $(dirname ${0}) && cd ../ && pwd)

cd ${DOCKER_PROJECT_PATH}

# docker image build -t hugo-dev . \
#                    --progress plain \
#                    --build-arg USER_NAME=$(id -nu ${USER}) \
#                    --build-arg GROUP_NAME=$(id -ng ${USER}) \
#                    --build-arg USER_ID=$(id -u ${USER}) \
#                    --build-arg GROUP_ID=$(id -g ${USER}) \
#                    --build-arg GO_VERSION=1.21.3 \
#                    --build-arg DART_SASS_VERSION=1.69.5 \
#                    --build-arg HUGO_VERSION=0.120.3
docker image build -t hugo-dev . \
                   --progress plain \
                   --build-arg USER_NAME=$(id -nu ${USER}) \
                   --build-arg GROUP_NAME=$(id -ng ${USER}) \
                   --build-arg USER_ID=$(id -u ${USER}) \
                   --build-arg GROUP_ID=$(id -g ${USER}) \
                   --build-arg HUGO_VERSION=0.120.3

docker system prune -f