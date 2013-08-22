[haskell-happstack] repository for Arch Linux
=============================================

This repository contains several Haskell packages for web development,
including most of [Happstack](http://happstack.com/),
[Gitit](http://gitit.net/) and [clckwrks](http://clckwrks.com/). It
also contains other Haskell packages not directly related to the web;
the complete list is in the `[buildorder](buildorder)` file. In order
to use it, the [haskell-core] repository must be enabled in
`/etc/pacman.conf`:

    [haskell-core]
    Server = http://xsounds.org/~haskell/core/$arch
    Server = http://www.kiwilight.com/haskell/core/$arch
    
    [haskell-happstack]
    Server = ftp://noaxiom.org/$repo/$arch
