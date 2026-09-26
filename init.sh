#!/bin/bash

filename="$1.sh"

countdown()
{
	local phrase=$1
	local secs=$2
	while [[ $secs -gt 0 ]];do
		echo -ne "$phrase $secs...\\033[0K\\r"
		sleep 1
		((secs--))
	done
}


if [[ -f $filename ]];then
	countdown "file already exists, switching to edit mode in" 2
	chmod +x $filename
	micro $filename
else
	touch $filename
	chmod +x $filename
	micro $filename
fi
