#!/bin/bash

usage(){
	echo "$0 <server_dir>"
	exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

SERVER_DIR=$1
TOPDIR=`dirname $0`/../

[ -d "$SERVER_DIR/.git" ] && {
	mv $SERVER_DIR/.git $TOPDIR/server_files/ 
}
rm -rf $1/*

#termux-apt-repo recreates directory, so it should be runned first
termux-apt-repo $TOPDIR/debs $SERVER_DIR/
cp -R bootstraps $SERVER_DIR/
cp -R $TOPDIR/server_files/* $SERVER_DIR/
[ -d "server_files/.git" ] && {
	mv $TOPDIR/server_files/.git $SERVER_DIR/
}
