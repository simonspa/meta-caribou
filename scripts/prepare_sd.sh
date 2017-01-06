#!/bin/bash

SD_DEVICE_DEFAULT="/dev/mmcblk0"

#Colours
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED="\033[0;31m"
NC='\033[0m'

cd ../../

#Set up bitbake
. oe-init-build-env

#Build wic dependencies
bitbake parted-native dosfstools-native mtools-native

#Create image
IMAGE_PATH=$( wic create sdimage-bootpart -e caribou-image | tee /dev/tty | grep "Info: The new image(s) can be found here:" -A1 | sed -n '2p' | sed 's/ //g' )

#Copy image to the SD card
read -p "Please enter absolute path SD card device [$SD_DEVICE_DEFAULT]: " SD_DEVICE
SD_DEVICE=${SD_DEVICE:-$SD_DEVICE_DEFAULT}

if sudo dd if=$IMAGE_PATH of=$SD_DEVICE bs=1M ; then
    #Wait till dd finishes
    printf "${ORANGE}Waiting for coping process to complete...\n"
    sudo sync

    printf "${GREEN}Done.\n"
else
    printf "${RED}Coping process failed !\n"
fi
printf "${NC}\n"

