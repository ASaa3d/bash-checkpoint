#!/bin/bash

arr=(foo bar baz 'hello my friend!!')

# copy array = mkaing a new empty array and add the old ones items to it
new_arr=("${arr[@]}")
# also += for appending to arr
new_arr+=("new element")

third_arr=([0]="asd" [1]="foo" [45]="element 45")

echo "${arr[0]}"
echo "${arr[1]}"
echo "${arr[2]}"

for item in "${third_arr[@]}";do
	echo "item is $item"
done

new_arr_inspection=$(declare -p new_arr)

echo "$new_arr_inspection"  
