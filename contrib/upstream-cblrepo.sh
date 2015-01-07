#!/bin/bash

function list ()
{
	cblrepo --db $1/cblrepo.db list $2 $3 | awk 'BEGIN{OFS="\t"}; { match($2, /(.*)-(.*)/, a);$2=a[1];$3=a[2]; print $1, $2, $3 };'
}

function mkjoin()
{
	join <(list . $2 $3) <(list upstream-repos/$1)
}

function pkgrel()
{
	mkjoin $1 -d --no-repo | awk 'BEGIN {OFS="\t"}; $2==$4 && $3!=$5 {print "'$1'", $1, $2, $3 " -> " $5 }'
}

function pkgver()
{
	mkjoin $1 -d --no-repo | awk 'BEGIN {OFS="\t"}; $2!=$4 {print "'$1'", $1, $2, $3, "->", $4 , $5 }'
}

function adopted()
{
	mkjoin $1 | awk 'BEGIN {OFS="\t"}; {print "'$1'", $1, $2, $3, "->", $4 , $5 }'
}

function all_upstream()
{
	list upstream-repos/$1 $2 $3 | cut -f1

}

function dropped ()
{
	join -v1 <(list . -d --no-repo) <(repos all_upstream | sort)
}


function repos
{
		for p in upstream-repos/*
		do
			$1 $(basename $p)
		done
}


echo "==> Package upgrade only (new release):"
repos pkgrel | column -t

echo "==> Software upgrade (new version):"
repos pkgver | column -t

echo "==> Adopted packages (our RepoPkg in upstream)"
repos adopted | column -t
echo "==> Dropped packages (our DistroPkg not in upstream)"
dropped | column -t
