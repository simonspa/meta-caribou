SUMMARY = "The BSP design for Caribou hardware"
DESCRIPTION = "It downloads from peary-firmware gitlab repostitory a bitstream and the HDF file (initialization ps7_init_gpl.c/h \
platform headers)."
SECTION = "bsp"
DEPENDS += "unzip"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta-caribou/COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

SRC_URI = "git://git@gitlab.cern.ch:7999/Caribou/peary-firmware.git;protocol=ssh;"
SRCREV = "447ca4e0ec5e5844b3882541f39f1d0a622637e6"

PV = "+git${SRCPV}"

S = "${WORKDIR}/git"

BIT = "outputs/caribou-soc.bit"
HDF = "outputs/caribou_top.hdf"

PROVIDES += "virtual/bitstream virtual/zynq7-platform-init"

PLATFORM_INIT ?= "ps7_init_gpl.c \
		  ps7_init_gpl.h"

FILES_${PN}-platform-init += " \
		${PLATFORM_INIT_DIR}/ps7_init_gpl.c \
		${PLATFORM_INIT_DIR}/ps7_init_gpl.h \
		"

FILES_${PN}-bitstream += " \
		download.bit \
		"

PACKAGES = "${PN}-platform-init ${PN}-bitstream"

BITSTREAM ?= "bitstream-${PV}-${PR}.bit"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit zynq7-platform-paths
inherit deploy

SYSROOT_DIRS += "${PLATFORM_INIT_DIR}"

do_install() {
	install ${S}/${BIT} ${D}/download.bit
	install -d ${D}${PLATFORM_INIT_DIR}
	for fn in ${PLATFORM_INIT}; do
		unzip -o ${S}/${HDF} ${fn} -d ${D}${PLATFORM_INIT_DIR}
	done
}

do_deploy () {
	if [ -e ${D}/download.bit ]; then
		install -d ${DEPLOYDIR}
		install -m 0644 ${D}/download.bit ${DEPLOYDIR}/${BITSTREAM}
		ln -sf ${BITSTREAM} ${DEPLOYDIR}/download.bit
	fi
}
addtask deploy before do_build after do_install
