---
title: Quickly setting up a Shepherd account in a UBOS container
---

If you run UBOS in a container with ``systemd-nspawn``, it may be a good
idea to make your home directory on the development machine available in
the container, so it's easy to move files around.

This can be accomplished by adding ``--bind /home/joe`` to the
``systemd-nspawn` invocation, assuming your home directory is indeed at
``/home/joe``.

If so, adding a shepherd account to the container becomes really simple,
using your existing public key pair in ``~/.ssh``. In the container,
execute:

```
% sudo ubos-admin setup-shepherd --add-key "$(cat /home/joe/.ssh/id_rsa.pub)"
```
