#!/usr/bin/env bash

ghc_version="7.10.3"

ghc_release="1"

cblrepo pkgbuild --ghc-version=${ghc_version} --ghc-release=${ghc_release} $@
