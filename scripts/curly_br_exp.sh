#!/bin/bash

filenames=(/etc/{foo,bar,baz}/{1,2,3}/.{txt,mov,sh})

for item in "${filenames[@]}";do
	echo "$item"
done
