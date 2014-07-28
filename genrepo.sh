#!/usr/bin/env bash

add_args="--sign --verify --delta --files"

for arch in i686 x86_64; do
    ifs_bkp=${IFS}
    IFS=$'\n'
    new_pkgs=""
    for p in $(cblrepo list)
    do
        name="$(echo $p | awk '{print $1;}')"
        version="$(echo $p | awk '{print $2;}')"
        lower_name="$(echo ${name} | tr '[:upper:]' '[:lower:]')"
        if [ -d "${lower_name}" ]
        then pkg_name="${lower_name}"
        else pkg_name="haskell-${lower_name}"
        fi
        pkg_path="${pkg_name}-${version}-${arch}.pkg.tar.xz"
        if [ -e "${pkg_name}/${pkg_path}" ]
        then
            if [ ! -e "repo/${arch}/${pkg_path}" ]
            then
                echo "Copying ${pkg_name}/${pkg_path} to repo/${arch}..."
                cp "${pkg_name}/${pkg_path}" "repo/${arch}"
                echo "Signing ${pkg_path}..."
                (cd "repo/${arch}"; gpg2 --detach-sign "${pkg_path}")
                new_pkgs="${new_pkgs} ${pkg_path}"
            fi
        fi
    done
    IFS=${ifs_bkp}
    (cd "repo/${arch}"
     repo-add ${add_args} haskell-happstack.db.tar.xz ${new_pkgs})
done
