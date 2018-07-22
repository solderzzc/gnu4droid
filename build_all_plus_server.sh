#!/bin/bash

set -e -u -o pipefail

TOPDIR=`dirname $0`/

$TOPDIR/scripts/build-bootstrap.sh
