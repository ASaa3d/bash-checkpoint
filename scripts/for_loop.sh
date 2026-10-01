#!/bin/bash

for i in {1..5}
do
	echo $i
done

for thing in foo bar asd bat;do
	echo $thing
done


for thing in "$@";do
	echo $thing
done


