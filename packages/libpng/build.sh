TERMUX_PKG_HOMEPAGE=http://www.libpng.org/pub/png/libpng.html
TERMUX_PKG_DESCRIPTION="Official PNG reference library"
TERMUX_PKG_VERSION=1.6.34
TERMUX_PKG_SHA256=574623a4901a9969080ab4a2df9437026c8a87150dfd5c235e28c94b212964a7
TERMUX_PKG_SHA256=2f1e960d92ce3b3abd03d06dfec9637dfbd22febf107a536b44f7a47c60659f6
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/libpng/libpng16/${TERMUX_PKG_VERSION}/libpng-${TERMUX_PKG_VERSION}.tar.xz
#TERMUX_PKG_SRCURL=ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng16/libpng-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_INCLUDE_IN_DEVPACKAGE="bin/libpng-config bin/libpng16-config"
TERMUX_PKG_RM_AFTER_INSTALL="bin/png-fix-itxt bin/pngfix"
TERMUX_PKG_KEEP_STATIC_LIBRARIES="yes"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-static "
