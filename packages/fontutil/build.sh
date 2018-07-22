TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.3.1
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/font/font-util-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-mapdir=$TERMUX_PREFIX/share/fonts/util
--with-fontrootdir=$TERMUX_PREFIX/share/fonts
"

