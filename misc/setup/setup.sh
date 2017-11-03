#!/bin/bash
# The script configures the whole poky framework and ads to it the meta-caribou layer.
# Be defualt the scripts uses the latest meta-caribou version from master.
# However, with GIT_CI parameter, it will not clone/pull poky/meta-caribou.

# get poky
export POKY_VERSION="pyro-17.0.2"
if [ ! -d poky ]; then
    git clone --branch $POKY_VERSION git://git.yoctoproject.org/poky
else
    git --git-dir=poky.git fetch
    git --git-dir=poky.git checkout $POKY_VERSION
fi

#get meta-caribou
if [ "$1" != "GIT_CI" ]; then
    if [ ! -d poky/meta-caribou ]; then
	git clone https://gitlab.cern.ch/Caribou/meta-caribou.git poky/meta-caribou
    else
	git --git-dir=poky/meta-caribou.git pull
    fi

    #add meta-caribou to the poky framework    
    ./poky/meta-caribou/scripts/addCaribouLayer.sh
fi
