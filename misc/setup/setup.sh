#!/bin/bash
# The script configures the whole poky framework and ads to it the meta-caribou layer.

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
    git -C poky/meta-caribou pull
fi

#add meta-caribou to the poky framework    
./poky/meta-caribou/scripts/addCaribouLayer.sh
