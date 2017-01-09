SUMMARY = "Caribou Linux kernel module"
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

inherit module

SRC_URI = "file://Makefile \
           file://caribou.c \
           file://COPYING \
          "

KERNEL_MODULE_AUTOLOAD += " caribou"

S = "${WORKDIR}"