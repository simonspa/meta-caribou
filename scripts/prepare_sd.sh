#!/bin/bash

echo "Please enter absolute path of FAT16 SD card partition: "
read SD_FAT

echo "Please enter absolute path of EXT4 SD card partition fr root file system: "
read SD_EXT

echo "Please enter desired MAC address (using colons as separator): "
read ETH_ADDR

echo "Please enter absoulte path to the build directory: "
read DIR
IMAGES=tmp/deploy/images/zc706-zynq7

ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

printf "${ORANGE}Installing uBoot components...${NC}\n"
cp -v $DIR/$IMAGES/boot.bin $SD_FAT/
cp -v $DIR/$IMAGES/u-boot.img $SD_FAT/

printf "${ORANGE}Installing Kernel and Device Tree...${NC}\n"
cp -v $DIR/$IMAGES/uImage $SD_FAT/
cp -v $DIR/$IMAGES/uImage-zynq-zc706.dtb $SD_FAT/

printf "${ORANGE}Installing Root Filesystem...${NC}\n"
cp -v $DIR/$IMAGES/caribou-image-zc706-zynq7.cpio.gz.u-boot $SD_FAT/
sudo tar x -C $SD_EXT -f $DIR/$IMAGES/caribou-image-zc706-zynq7.tar.gz

read -p "Rewriting uEnv file? " -n 1 -r
printf "\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "${ORANGE}Create uEnv file...\n"
    printf "kernel_image=uImage
devicetree_image=uImage-zynq-zc706.dtb
ramdisk_image=core-image-full-cmdline-zc706-zynq7.cpio.gz.u-boot
bootargs=root=/dev/mmcblk0p2 rw rootwait
ethaddr=${ETH_ADDR}
uenvcmd=fatload mmc 0 0x3000000 \${kernel_image} && fatload mmc 0 0x2A00000 \${devicetree_image} && bootm 0x3000000 - 0x2A00000
" > $SD_FAT/uEnv.txt
fi

printf "${GREEN}Done.\n"
printf "${NC}\n"

