#!/bin/bash

pipe_path="./pipe"

[[ -p "$pipe_path" ]] || mkfifo "$pipe_path"


client_pids=()
client(){
	while true;do
		echo "Hello Im $1, time now is $(date +%H:%M:%S)">$pipe_path
		sleep 2
	done
}

client "sa3d" &
client_pids+=($!)
client "dave" &
client_pids+=($!)
client "jo" &
client_pids+=($!)

trap cleanup EXIT SIGINT SIGTERM
cleanup(){
    echo "Caught exit signal! Cleaning up background clients..."
 
	kill -9 "${client_pids[@]}"
	rm -rf "$pipe_path"

	exit 0
}




while true;do
	while read -r line;do
		echo $line
	done < pipe
done
