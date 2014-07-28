#!/usr/bin/env bash

IFS=$'\n'

for p in $(cblrepo list)
do
    name=$(echo $p | awk '{print $1;}')
    pkg_name=haskell-$(echo ${name} | tr '[:upper:]' '[:lower:]')
    repo=$(pacman -Si "haskell-core/${pkg_name}" 2> /dev/null | awk '/Name/ {print $3;}' | head -n 1)
    if [ ${repo} ]; then
        repo_ver=$(pacman -Si "haskell-core/${repo}" | awk '/Version/ {print $3;}')
        echo ${repo#haskell-}-${repo_ver}
    fi
done
