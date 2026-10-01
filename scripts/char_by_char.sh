#!/bin/bash

usr_in=${1:?"input Required"}
in_len=${#usr_in}


for (( i=0;i<in_len;i++ ));do
	c=${usr_in:i:1}
	echo "$c"
done
