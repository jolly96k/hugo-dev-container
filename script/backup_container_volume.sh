#! /usr/bin/env bash

set -euxo pipefail

if [ -n ${LOGNAME} ]
then
    USER=${LOGNAME}
fi

SCRIPT_DIRNAME=$(cd $(dirname $0) && pwd)
DOCKER_PROJECT_PATH=$(cd $(dirname $0) && cd ../ && pwd)

HUGO_VOLUME_PATH=${DOCKER_PROJECT_PATH}/hugo/volume
HUGO_BACKUP_PATH=${DOCKER_PROJECT_PATH}/hugo/.backup

cd ${SCRIPT_DIRNAME}

mkdir -p ${HUGO_BACKUP_PATH}/usr/local/share

rsync -avh \
      --delete \
      --chmod D775,F664 \
      --chown ${USER}:${USER} \
      ${HUGO_VOLUME_PATH}/usr/local/share/hugo_workspace \
      ${HUGO_BACKUP_PATH}/usr/local/share