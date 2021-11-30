---
title: How are the various UBOS images different from each other?
---

UBOS images for containers are identical to those for physical machines, except that
they do not run certain services by default which are usually provided by the
host (such as for setting the system time).

UBOS images for VirtualBox by default run the VirtualBox client tools, which enables
the virtual machine to integrate better with the host system.

The differences between the images on x86_64 are very small; one or two packages installed
or not, and a handful of ``systemctl enable ...`` calls, so if you already have an image
for x86_64, it should be straightforward to use it for physical machine, VirtualBox
or containers without needing to download another image.

On ARM platforms, that's a bit different: while the core code of the image is the same
for each major ARM revision, the various boards vary quite dramatically in terms of how
they boot, or which peripherals they need to know about. So it would be unlikely that you
would get an image for one ARM board to boot on another. The exception is the Raspberry Pi,
where versions Zero and 1 share the same image, as do 2 and 3.

