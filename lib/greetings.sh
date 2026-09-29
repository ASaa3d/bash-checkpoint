#!/bin/bash

greet(){
	if [[ -z $1 ]];then
		echo "input not given">&2
	else
		echo "hi $1">&1
	fi
}

goodbye(){
	if [[ -z $1 ]];then
		echo "input not given">&2
	else
		echo "goodbye $1">&1
	fi
}

if !(return 2>/dev/null);then
	# we are source
	greet admin
	my_cmd=$(greet 2>&1)
	echo "$my_cmd"
	goodbye admin

fi
