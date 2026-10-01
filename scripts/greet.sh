#!/bin/bash

if [[ -z "$1" ]];then
	read -p "whats your name: " name
else
	name="$1"
fi
echo -e "Hello $name!!!"
