#!/bin/bash
#The script builds locally the meta-caribou image using a docker container from remote gitlab repository.
#It uses the latest master version of meta-caribou.
#The script creates/reuses 'downloads' and 'sstate-cache' directories to store the poky sources and cache the intermediate stages.
#It allows to speed up the build process if the script is called again in the same directory.

export IMAGE_PATH=/builds/poky/wic
export DOCKER_IMAGE=gitlab-registry.cern.ch/caribou/meta-caribou
export DOCKER_CONTAINER=meta-caribou-container

docker pull gitlab-registry.cern.ch/caribou/meta-caribou
if [ ! -d downloads ]; then
    mkdir -m a+rw downloads
elif [ `stat -c %A  downloads | sed 's/.\{7\}\(..\)./\1/'` != "rw" ]; then
    echo "ERROR: The existing downloads directory needs to give read and write access to all users"
    exit 1
fi

if [ ! -d sstate-cache ]; then
    mkdir -m a+rw sstate-cache
elif [ `stat -c %A  sstate-cache | sed 's/.\{7\}\(..\)./\1/'` != "rw" ]; then 
    echo "ERROR: The existing 'sstate-cache' directory needs to give read and write access to all users"
    exit 1
fi

if [ ! "$(docker ps -q -f name=${DOCKER_CONTAINER})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${DOCKER_CONTAINER})" ]; then
        # cleanup
        docker rm ${DOCKER_CONTAINER}
    fi
fi
docker run -it --net=host -v ${PWD}/downloads:/downloads -v  ${PWD}/sstate-cache:/sstate-cache --name=${DOCKER_CONTAINER} ${DOCKER_IMAGE}:latest
docker cp ${DOCKER_CONTAINER}:${IMAGE_PATH}/ .
