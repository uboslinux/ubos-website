---
title: My SD card is much larger than the UBOS image. How do I use the rest of the space?
---

It would be best if you don't burn the UBOS image to your large SD Card, but instead
to a temporary SD card. Then you boot from the temporary card, and use ``ubos-install``
to create a clean new installation on your large SD Card. ``ubos-install`` will use
all available space. Then you can discard your temporary SD card.

You can also expand the file system, but note that this is an expert-level operation;
you can very easily screw your existing UBOS installation and all data on it. So be
very careful. In principle, it should work like this: first determine what filesystem
your UBOS root partition runs on. On most devices, UBOS runs on "btrfs" but it might be
"ext4". Then, use a command specific to that filesystem type to expand the filesystem,
such as ``btrfs filesystem resize`` (for "btrfs) or ``resize2fs`` (for "ext4").
Alternatively, you can add a second device to the btrfs filesystem pool.

