#!/usr/bin/env bash

for arch in i686 x86_64; do
    cd "repo/${arch}"
    for f in *-${arch}.pkg.tar.xz; do
        if ! xzgrep ${f%-${arch}.pkg.tar.xz}/ haskell-happstack.db.tar.xz 1> /dev/null
        then
            echo "Removing ${f}..."
            rm ${f}{,.sig}
        fi
    done
    cd ../..
done
