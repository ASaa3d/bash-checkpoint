#!/bin/bash


cleanup(){
	echo "Function cleaning running"
	exit 2
}

debugger(){
	printf "%(%H:%M)T [DEBUG]: %s\n" -1 "$BASH_COMMAND"
}

trap cleanup exit
trap debugger debug
echo "script is runnning.."
sleep 5
echo "script done"
exit 1
