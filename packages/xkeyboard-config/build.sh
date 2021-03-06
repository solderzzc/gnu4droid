TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=2.20
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/data/xkeyboard-config/xkeyboard-config-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=d1bfc72553c4e3ef1cd6f13eec0488cf940498b612ab8a0b362e7090c94bc134
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_DEPENDS=libx11
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--with-xkb-rules-symlink=xorg
--with-xkb-base=$TERMUX_PREFIX/share/X11/xkb
--enable-compat-rules=yes
"
