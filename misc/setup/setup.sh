#!/bin/bash
#The script configures the whole poky framework and ads to it the meta-caribou layer.
#By default, the script uses the latest meta-caribou version from the master branch.
#However, with GIT_CI parameter, it will not clone/pull poky/meta-caribou.

# get poky
export POKY_VERSION="pyro-17.0.2"
if [ ! -d poky ]; then
    git clone --branch $POKY_VERSION git://git.yoctoproject.org/poky
else
    git --git-dir=poky/.git --work-tree=poky fetch
    git --git-dir=poky/.git --work-tree=poky checkout $POKY_VERSION
    git --git-dir=poky/.git --work-tree=poky reset --hard
fi
git --git-dir=poky/.git --work-tree=poky -c user.name=caribou-ci -c user.email=caribou-ci@cern.ch cherry-pick 717303e6fbcbbe181ad9645d762eb5a85d934523

#get meta-caribou
if [ "$1" != "GIT_CI" ]; then
    if [ ! -d poky/meta-caribou ]; then
	git clone https://gitlab.cern.ch/Caribou/meta-caribou.git poky/meta-caribou
    else
	git --git-dir=poky/meta-caribou/.git pull
    fi

    #add meta-caribou to the poky framework    
    ./poky/meta-caribou/scripts/addCaribouLayer.sh
fi
