#!/bin/bash

i=0
while read -r word;do
	echo "$word"
	(( i++ ))
done< <(grep f ./gsch.txt)

echo "found $i matches"
