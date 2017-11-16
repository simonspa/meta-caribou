#!/bin/bash
export IMAGE_PATH=/builds/poky/wic
export GIT_PATH=/builds/poky/meta-caribou

if [[ -v CI ]]; then  #running in CI
    git clone ${CI_REPOSITORY_URL} ${GIT_PATH}
    git --git-dir=${GIT_PATH}/.git --work-tree=${GIT_PATH} checkout ${CI_COMMIT_SHA}
else                  # otherwise, use latest master
    git clone https://gitlab.cern.ch/Caribou/meta-caribou.git ${GIT_PATH}
fi
cd /builds/poky
source meta-caribou/scripts/addCaribouLayer.sh GIT_CI
.  oe-init-build-env
bitbake caribou-image
bitbake wic-tools
IMAGE_FULL_PATH=$( wic create sdimage-bootpart -e caribou-image -o ${IMAGE_PATH} 2>&1 |  grep "INFO:\ The\ new image(s)\ can\ be\ found\ here:" -A1 |  sed -n '2p' )
mv $IMAGE_FULL_PATH ${IMAGE_PATH}/sdimage-${CI_COMMIT_SHA:0:8}-mmcblk.direct
