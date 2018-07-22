TERMUX_PKG_HOMEPAGE=https://gnupg.org/related_software/libksba/
TERMUX_PKG_DESCRIPTION="Library for using X.509 certificates and CMS (Cryptographic Message Syntax) easily accessible"
TERMUX_PKG_VERSION=1.3.5
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libksba/libksba-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=41444fd7a6ff73a79ad9728f985e71c9ba8cd3e5e53358e70d5f066d35c1a340
TERMUX_PKG_DEPENDS="libgpg-error"
TERMUX_PKG_INCLUDE_IN_DEVPACKAGE=bin/ksba-config
