#!/bin/bash

if ! declare -A arr; then
	echo "this shell doesn/t support associative arrays"
fi

arr[foo]=1
arr[bar]=2
arr[baz]=3


for key in "${!arr[@]}";do
	val=${arr[$key]}
	echo "($key -> $val)"
	
done
