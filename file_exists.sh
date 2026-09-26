#!/bin/bash
	
if [[ -n $1 && -f $1 ]] ;then
	echo "$1 exists"
else
	echo "file does not exist"
fi
