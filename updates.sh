#!/usr/bin/env bash

usage=$'Usage: update.sh [-abh]\n\nOptions:\n    -a\tProduce the update list in the format for \"cblrepo add\"\n    -b\tProduce the update list in the format for \"cblrepo bump\"\n    -h\tShow this help message'

prog='$3 != $4 { print $2, $3, ": found version", $4, "in repository" }'

while getopts abh opt; do
    case $opt in
        a)
            prog='BEGIN    { ORS = "" }
                  $3 != $4 { print " -d " $2 "," gensub("[-_]", ",", "g", $4) }
                  END      { print "\n" }'
            ;;
        b)
            prog='BEGIN    { ORS = "" }
                  $3 != $4 { print " " $2 }
                  END      { print "\n" }'
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

export LC_COLLATE=C

join <(cblrepo list -d --no-repo | awk '{ print "haskell-" tolower($1), $1, $2 }' | sort) \
     <(pacman -Sl haskell-core | awk '{ print $2, $3 }' | sort) \
    | sort --key=2,2 \
    | awk "${prog}"
