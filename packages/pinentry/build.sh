TERMUX_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
TERMUX_PKG_DESCRIPTION="Dialog allowing secure password entry"
TERMUX_PKG_VERSION=1.1.0
TERMUX_PKG_SHA256=68076686fa724a290ea49cdf0d1c0c1500907d1b759a3bcbfbec0293e8f56570
TERMUX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_DEPENDS="libandroid-support, libassuan, ncurses"
TERMUX_PKG_BUILD_DEPENDS="libgpg-error"
