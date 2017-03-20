FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"
SRC_URI = "git://git@gitlab.cern.ch:7999/Caribou/peary-firmware.git;protocol=ssh; \
           file://0001-Extend-peary-firmware-device-tree-generated-by-Vivad.patch \
           file://0001-Add-SPI-interface-of-the-CLICpix2-chip-to-the-device.patch \
           "

SRCREV = "${AUTOREV}"

PV = "1.0+git${SRCPV}"

S = "${WORKDIR}/git"

DEVICETREE_caribou-zynq7 = "${S}/outputs/dts/system-top.dts"

KERNEL_DTS_INCLUDE_caribou-zynq7 = "\
			git/outputs/dts \
			"		

MACHINE_DEVICETREE_caribou-zynq7 = " \
			   git/outputs/dts/system.dts \
			   git/outputs/dts/system-top.dts \
			   git/outputs/dts/pcw.dtsi \	
			   git/outputs/dts/skeleton.dtsi \
			   git/outputs/dts/zynq-7000.dtsi \
			   git/outputs/dts/pl.dtsi \
			   "

