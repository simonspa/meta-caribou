DESCRIPTION = "DAQ framework for the Carioub DAQ System"

LICENSE = "LGPLv3"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=c160dd417c123daff7a62852761d8706"

SRC_URI = "gitsm://git@gitlab.cern.ch:7999/Caribou/peary.git;protocol=ssh"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

DEPENDS = "i2c-tools readline"

# Specify any options you want to pass to cmake using EXTRA_OECMAKE:
EXTRA_OECMAKE = " -DBUILD_example=ON \
	          -DINSTALL_PREFIX=/usr/ \
		  -DCMAKE_SKIP_RPATH=ON \
	       "
FILES_${PN}  += "${FILES_SOLIBSDEV}"
FILES_${PN}-dev = ""

INSANE_SKIP_${PN} = "dev-so"