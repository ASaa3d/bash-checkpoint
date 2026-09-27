#!/bin/bash

thing="$(whoami)"
echo "thing is $thing"

echo $(whoami)

echo $(echo $(whoami))

echo $(echo $(echo $(whoami)))

