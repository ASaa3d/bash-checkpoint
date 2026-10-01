#!/bin/bash


libdir="./lib"
lib_ver=""
if [[ -n $1 ]];then
	lib_ver="/$1"
fi

source -p "$libdir$lib_ver" greetings.sh || exit 66

greet sa3d
greet dave
goodbye jo
