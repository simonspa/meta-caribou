#!/bin/bash
#The script configures the whole poky framework and ads to it the meta-caribou layer.
#By default, the script uses the latest meta-caribou version from the master branch.
#However, with GIT_CI parameter, it will not clone/pull poky/meta-caribou.

# get poky
export POKY_VERSION="rocko-18.0.0"
if [ ! -d poky ]; then
    git clone --branch $POKY_VERSION git://git.yoctoproject.org/poky
else
    git --git-dir=poky/.git --work-tree=poky fetch
    git --git-dir=poky/.git --work-tree=poky checkout $POKY_VERSION
    git --git-dir=poky/.git --work-tree=poky reset --hard
fi

###patch wic
patch=$(mktemp /tmp/poky-setup.XXX)
curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/remote_scripts/0001-wic-Fix-a-path-to-a-psuedo-state-directory-PSEUDO_LO.patch > "$patch"
cd poky
git config user.name "caribou-ci"
git config user.email "caribou-ci@cern.ch"
git am "$patch"
cd $OLDPWD
rm "$patch"
###

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
