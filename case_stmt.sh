#!/bin/bash

usr_in=$1
case $usr_in in
	"apple")
		echo "healthy"
		;;
	"fruit")
		echo "healthy"
		;;
	"fried")
		echo "not healthy"
		;;

	*)
		echo "unknown"
		;;
esac
