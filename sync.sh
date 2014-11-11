#!/usr/bin/env bash

repo_host="root@noaxiom.org"
repo_name="haskell-happstack"
repo_path="/srv/noaxiom/${repo_name}"

rsync_arguments="-rtlvH --delete-after --delay-updates --safe-links --max-delete=1000"

for arch in i686 x86_64; do
    echo "Syncing ${arch} repository..."
    rsync ${rsync_arguments} "repo/${arch}/" "${repo_host}:${repo_path}/${arch}"
done
