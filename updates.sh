#!/usr/bin/env bash

mode="echo"

usage=$'Usage: update.sh [-abh]\n\nOptions:\n    -a\tProduce the update list in the format for \"cblrepo add\"\n    -b\tProduce the update list in the format for \"cblrepo bump\"\n    -h\tShow this help message'


while getopts abh opt; do
    case $opt in
        a)
            mode="add"
            ;;
        b)
            mode="bump"
            ;;
        h)
            echo "${usage}"
            exit 0
            ;;
        *)
            echo "${usage}"
            exit 1
            ;;
    esac
done

IFS=$'\n'

for p in $(cblrepo list -d --no-repo)
do
    name=$(echo $p | awk '{print $1;}')
    ver=$(echo $p | awk '{print $2;}')
    pkg_name=haskell-$(echo ${name} | tr '[:upper:]' '[:lower:]')
    repo_ver_rel=$(pacman -Si "${pkg_name}" | awk '/Version/ {print $3;}' | head -n 1)
    if [ "${ver}" != "${repo_ver_rel}" ]
    then
        case ${mode} in
            "add")
                repo_ver=${repo_ver_rel%-*}
                repo_rel=${repo_ver_rel#*-}
                add="${add} -d ${name},${repo_ver},${repo_rel}"
                ;;
            "bump")
                bump="${bump} ${name}"
                ;;
            *)
                echo ${name} ${ver} : found version ${repo_ver_rel} in repository;;
        esac
    fi
done

case ${mode} in
    "add")
        echo ${add};;
    "bump")
        echo ${bump};;
esac
