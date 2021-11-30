---
title: 'Updating UBOS fails with lots of error messages containing "Unrecognized archive format"'
---

You probably haven't updated your {{% gl Device %}} for a long time. In the meantime, we have
started distributing some packages with a new, faster, compression scheme, and your
version of ``pacman`` and dependent libraries are too old to recognize it. So upgrade
``pacman`` and ``libarchive`` first.

First, find the cached ``pacman`` and ``libarchive`` packages on your system:

```
% find /var/cache/pacman -name pacman-\* -or -name libarchive\*
```

Then, if the names of the found files are, for example,
``/var/cache/pacman/pkg/pacman-5.2.1-4-x86_64.pkg.tar.zst`` and
``/var/cache/pacman/pkg/libarchive-3.4.1-1-x86_64.pkg.tar.zst``, copy those files locally
and uncompress them:

```
% cp /var/cache/pacman/pkg/pacman-5.2.1-4-x86_64.pkg.tar.zst .
% cp /var/cache/pacman/pkg/libarchive-3.4.1-1-x86_64.pkg.tar.zst .
% zstd -d pacman-5.2.1-4-x86_64.pkg.tar.zst
% zstd -d libarchive-3.4.1-1-x86_64.pkg.tar.zst
```

Then, install the uncompressed files:

```
% sudo pacman -U pacman-5.2.1-4-x86_64.pkg.tar libarchive-3.4.1-1-x86_64.pkg.tar
```

and proceed as you regularly would with updating UBOS.

