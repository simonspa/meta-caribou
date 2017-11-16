#!/bin/bash
export IMAGE_PATH=/builds/poky/wic
git clone https://gitlab.cern.ch/Caribou/meta-caribou.git /builds/poky/meta-caribou
cd /builds/poky
source meta-caribou/scripts/addCaribouLayer.sh GIT_CI
.  oe-init-build-env
bitbake caribou-image
bitbake wic-tools
IMAGE_FULL_PATH=$( wic create sdimage-bootpart -e caribou-image -o ${IMAGE_PATH} 2>&1 |  grep "INFO:\ The\ new image(s)\ can\ be\ found\ here:" -A1 |  sed -n '2p' )
