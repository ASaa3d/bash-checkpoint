#!/bin/bash

if [[ -z $1 || $1 == '#'* ]];then
	echo "no input given">&2
	exit 1
fi

declare -A shells
while IFS=: read -r name enc_passwd uid gid usr_name usr_dir shell;do
	if [[ $name == '#'* ]];then
		continue
	fi
	shells[$name]=$shell
done < /etc/passwd

echo "$1 has ${shells[$1]} shell"
