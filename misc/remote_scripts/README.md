# Remote scripts

## setup.sh
The script configures the whole poky framework and ads to it the meta-caribou layer.
By default, the script uses the latest meta-caribou version from the master branch.
However, with GIT_CI parameter, it will not clone/pull poky/meta-caribou.

## build.sh
The script builds locally the meta-caribou image using a docker container from remote gitlab repository.
It uses the latest master version of meta-caribou.
The script creates/reuses 'downloads' and 'sstate-cache' directories to store the poky sources and cache the intermediate stages. It allows to speed up the build process if the script is called again in the same directory.
