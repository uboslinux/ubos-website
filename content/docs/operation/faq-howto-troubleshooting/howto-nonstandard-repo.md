---
title: How to enable non-standard Package Repositories
---

The active {{% gl Package %}} {{% gls Repository %}} are defined in
``/etc/pacman.conf``. However, unlike on Arch Linux, this section of
the file is automatically maintained by UBOS.

To add a non-standard {{% gl Repository %}}, add a fragment file to
``/etc/pacman.d/repositories.d/`` in a similar manner as the files already
there.

In particular, to enable the ``toyapps`` {{% gl Repository %}}, edit
``/etc/pacman.d/repositories.d/toyapps`` and uncomment the commented-out
lines there.

Then, re-run:

```
% sudo ubos-admin update
```

so UBOS will update ``/etc/pacman.conf``.
