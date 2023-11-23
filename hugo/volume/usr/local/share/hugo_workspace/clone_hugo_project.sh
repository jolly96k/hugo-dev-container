#! /usr/bin/env bash

set -euxo pipefail

SCRIPT_DIRNAME=$(cd $(dirname ${0}) && pwd)

HUGO_PROJECT_GIT_URL=https://rm.zetsubo.net/ze/zetsubo-engineer.git
HUGO_PROJECT_GIT_BRANCH=main

cd ${SCRIPT_DIRNAME}

git clone ${HUGO_PROJECT_GIT_URL} -b ${HUGO_PROJECT_GIT_BRANCH} \
                                  --recurse-submodules