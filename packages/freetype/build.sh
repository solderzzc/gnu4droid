TERMUX_PKG_HOMEPAGE=https://www.freetype.org
TERMUX_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
TERMUX_PKG_VERSION=2.9
TERMUX_PKG_SHA256=bf380e4d7c4f3b5b1c1a7b2bf3abb967bda5e9ab480d0df656e0e08c5019c5e6
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/project/freetype/freetype2/${TERMUX_PKG_VERSION}/freetype-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SRCURL=https://download.savannah.gnu.org/releases/freetype/freetype-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_DEPENDS="libbz2, libpng"
TERMUX_PKG_INCLUDE_IN_DEVPACKAGE="bin/freetype-config share/man/man1/freetype-config.1"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
TERMUX_PKG_KEEP_STATIC_LIBRARIES="yes"
