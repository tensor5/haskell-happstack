[haskell-happstack] repository for Arch Linux
=============================================

This repository contains several Haskell packages for web development,
including most of [Happstack](http://happstack.com/),
[Gitit](http://gitit.net/) and [clckwrks](http://clckwrks.com/). It also
contains other Haskell packages not directly related to the web; the
complete list is in the [`buildorder`](buildorder) file. In order to use
it, the [haskell-core] repository must be enabled in `/etc/pacman.conf`:

    [haskell-core]
    Server = http://xsounds.org/~haskell/core/$arch
    
    [haskell-happstack]
    Server = ftp://noaxiom.org/$repo/$arch

Add and sign the PGP key:

    # pacman-key -r B0544167
    # pacman-key --lsign-key B0544167

To build and maintain the repository we use
[cblrepo](http://hackage.haskell.org/package/cblrepo) and the
[`makeahpkg`](makeahpkg) script taken from
[habs](https://github.com/archhaskell/habs):

    # cblrepo pkgbuild $(<buildorder)
    # ./makeahpkg -c $(<buildorder)

Check [habs](https://github.com/archhaskell/habs) for more details on
[`makeahpkg`](makeahpkg) usage.
