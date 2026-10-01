#!/bin/bash

greet(){
	local name=$1
	echo "Hello $name !!"
}

for name in "$@";do
	#./greet.sh $name
	greet $name
done
