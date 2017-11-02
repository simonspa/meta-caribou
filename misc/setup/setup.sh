#!/bin/bash
# The script configures the whole poky framework and ads to it the meta-caribou layer.
# Be defualt the scripts uses the latest meta-caribou version from master.
# However, with DO_NOT_PULL parameter, it will keep poky/meta-caribou directory without changes.

# get poky
export POKY_VERSION="pyro-17.0.2"
if [ ! -d poky ]; then
    git clone --branch $POKY_VERSION git://git.yoctoproject.org/poky
else
    git -C poky fetch
    git -C poky checkout $POKY_VERSION
fi

#get meta-caribou
if [ ! -d poky/meta-caribou ]; then
    git clone https://gitlab.cern.ch/Caribou/meta-caribou.git poky/meta-caribou
else
    if [ "$1" != "DO_NOT_PULL" ]; then
	git -C poky/meta-caribou pull
    fi
fi

#add meta-caribou to the poky framework    
./poky/meta-caribou/scripts/addCaribouLayer.sh
