FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-support-for-CaR-I2C-chains.patch \
	    file://0002-Add-support-for-I2C-PCA984x-family-switch-multiplexe.patch \
	 "
