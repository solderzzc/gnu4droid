TERMUX_PKG_HOMEPAGE=https://tukaani.org/xz/
TERMUX_PKG_DESCRIPTION="XZ-format compression library"
TERMUX_PKG_VERSION=5.2.4
TERMUX_PKG_SHA256=9717ae363760dedf573dad241420c5fea86256b65bc21d2cf71b2b12f0544f4b
TERMUX_PKG_SRCURL=https://tukaani.org/xz/xz-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_KEEP_STATIC_LIBRARIES="yes"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-static "
