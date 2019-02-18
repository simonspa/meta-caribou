DESCRIPTION = "EUDAQ module"

LICENSE = "LGPLv3"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=e6a600fd5e1d9cbde2d983680233ad02"

SRC_URI = "gitsm://github.com/eudaq/eudaq.git;protocol=https"

# Modify these as desired
PV = "0.1+git${SRCPV}"
SRCREV = "v2.2.0"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

DEPENDS = "peary"

# Specify any options you want to pass to cmake using EXTRA_OECMAKE:
EXTRA_OECMAKE = " -DUSER_CARIBOU_BUILD=ON \
                  -DEUDAQ_BUILD_GUI=OFF \
                  -DEUDAQ_INSTALL_PREFIX=/usr/ \
                  -DPEARYLIBS=${STAGING_LIBDIR} \
                  -DPEARYINCLUDE=${STAGING_INCDIR}/peary \
                "

FILES_SOLIBSDEV = ""
FILES_${PN} += "${FILES_SOLIBSDEV}"
FILES_${PN} += "${libdir}/*"

FILES_${PN}-dev += "usr/cmake/*"
FILES_${PN}-dev += "${includedir}"

INSANE_SKIP_${PN} = "dev-so"

LDFLAGS=""
