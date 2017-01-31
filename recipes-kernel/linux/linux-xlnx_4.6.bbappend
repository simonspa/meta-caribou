FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-support-for-I2C-PCA984x-family-switch-multiplexe.patch \
	    file://spidev.cfg \
	    file://0001-Add-caribou-chip-compatibility-to-spidev-driver.patch \
	   "
