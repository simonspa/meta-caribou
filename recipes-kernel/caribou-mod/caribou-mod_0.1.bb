SUMMARY = "Caribou Linux kernel module"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

SRC_URI = "file://Makefile \
           file://caribou.c \
           file://COPYING \
          "

KERNEL_MODULE_AUTOLOAD += " caribou"

S = "${WORKDIR}"