#!/bin/sh
. termhelper-functions
_th_load_config
if [ ! "$HELLO" -a "$EUID" -ne 0 ] ; then
	termhelper % header
fi

