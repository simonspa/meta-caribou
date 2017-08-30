FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI = "gitsm://gitlab.cern.ch/Caribou/peary-firmware.git;protocol=https; \
           file://0001-Add-I2C-muxes-of-the-CaR-board-to-the-device-tree.patch;striplevel=3 \
	   file://0002-Add-CLICpix2-SPI-interface-to-the-device-tree.patch;striplevel=3 \
           "

SRCREV = "${AUTOREV}"

PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git/outputs/dts/"

KERNEL_DTS_INCLUDE_caribou-zynq7 = "\
			git/outputs/dts \
			"		
