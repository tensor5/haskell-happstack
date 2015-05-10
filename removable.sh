#!/usr/bin/env bash

IFS=$'\n'

for p in $(cblrepo list -d -g)
do
    name=$(echo $p | awk '{print $1;}')
    if cblrepo -n rm "${name}" 2> /dev/null
    then echo "${name}"
    fi
done
