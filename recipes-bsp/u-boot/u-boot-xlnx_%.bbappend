FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Enable-bit-file-download.patch \
	    file://uEnv.txt"

UBOOT_ENV = "uEnv"


FORCE_PS7INIT = "1"