#!/bin/bash

res=$(( 57*2  ))
((res2 =  57*2 ))
i=2
$(( i <<= 5 ))
echo $res
echo $res2
echo "i = $i"
