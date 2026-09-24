
while
result=zero
echo "Please enter a number: "
read usr_num
do
	if [ $usr_num -gt 0 ]; then
		result=positive
	elif [ $usr_num -lt 0 ]; then
		result=negative
	fi
	echo -e "number is $result\n"

done

