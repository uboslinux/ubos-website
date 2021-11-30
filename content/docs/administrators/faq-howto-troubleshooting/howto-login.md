---
title: How to log into your UBOS Device
---


### I cannot login as root into a UBOS container from the console

If the error message is "login incorrect", that may be because somebody in an upstream
package (not sure which upstream package, but it wasn't us) changed the terminal for the
root console. To make this work again, from your host, edit the ``/etc/securetty`` file
by adding a new line with the content ``pts/0``.

For example, if your container's root directory is at ``~/ubos``, as root, you would be
editing file ``~/ubos/etc/securetty``.


