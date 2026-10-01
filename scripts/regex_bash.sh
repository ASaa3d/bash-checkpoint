#!/bin/bash

files=("img1 lbl - 2022-10-31.jpg" "img2 lbl - 2023-05-20.jpg")

regex="^(.*) - ([0-9]{4}-[0-9]{2}-[0-9]{2})\..*$"
for file in "${files[@]}";do
	if [[ $file =~ $regex ]];then
		name=${BASH_REMATCH[1]}
		date=${BASH_REMATCH[2]}
		echo "$date: $name"
	fi
done
