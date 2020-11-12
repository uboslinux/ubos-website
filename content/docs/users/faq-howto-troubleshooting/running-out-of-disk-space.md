---
title: I'm running out of disk space, what now?
---

## Overview

The default images for UBOS aren't very large, so they can fit onto cheap SD cards, USB
sticks and small Amazon EC2 root volumes. That works fine if you don't have a lot of
data on your device. But what if you do?

There are two ways to solve this issue:

* Pick a new disk that has the size you need, install UBOS on that disk and also keep
  your data on that disk.

* Keep running UBOS on one disk, and add a new disk that has the size you need as a
  "data" disk.

It's easiest to get set up correctly for either alternative before you install any
{{% gls App %}} on your {{% gl Device %}}. However, we also have instructions for how
to migrate once you have.

## Using a large, single disk that contains both operating system and data

The best way to do that is to run ``ubos-install`` on the new disk, using a {{% gl Device %}}
that runs UBOS already. Here are the steps:

### If you are starting from scratch:

1. Download a UBOS image for your platform, and boot your {{% gl Device %}} with it.

1. Attach your big future root disk to the {{% gl Device %}}. If it's an SD card,
   that requires a USB-SD card adapter.

1. Identify which block device corresponds to your disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.

1. Run ``ubos-install`` with the block device you identified.

1. Shut down your {{% gl Device %}}.

1. Remove your old boot disk, and attach your new boot disk in its place.

1. Reboot from the new disk.

### If you have Apps and data on your Device already:

1. Boot your {{% gl Device %}}.

1. Attach your big future root disk to the {{% gl Device %}}. If it's an SD card,
   that requires a USB-SD card adapter.

1. Identify which block device corresponds to your disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.

1. Run ``ubos-install`` with the block device you identified.

1. Mount the root partition of your new disk. Assuming
   the new root partition is ``/dev/sdb2``, execute:

   ```
   % sudo mount /dev/sdb2 /mnt
   ```

1. Back up your {{% gls Site %}} to a suitable directory of the mounted disk, such as:

   ```
   % sudo ubos-admin backup --backuptofile /mnt/root/from-small-disk.ubos-backup
   ```

1. Unmount your new disk, and shut down your {{% gl Device %}}:

   ```
   % sudo umount /mnt
   % sudo systemctl poweroff
   ```

1. Remove your old boot disk, and attach your new boot disk in its place.

1. Boot with the new disk.

1. Restore your data from backup:

   ```
   % sudo ubos-admin restore --in /root/from-small-disk.ubos-backup
   ```

## Using an additional "data" disk

### If you are starting from scratch:

1. Boot your {{% gl Device %}}.

1. Attach your big data disk to the {{% gl Device %}}.

1. Identify which block device corresponds to your data disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.

1. Make sure your data disk is formatted with either ``ext4`` or ``btrfs``. We recommend
   ``btrfs`` as UBOS takes advantage of copy-on-write features, thereby saving disk space
   and speeding up some operations. You can use your entire disk, or just one partition.

1. Mount your data disk at ``/ubos`` by executing:

   ```
   % sudo mount /dev/sdb2 /ubos
   ```

1. Update ``/etc/fstab`` so that the disk will be automatically mounted after a reboot.
   This is important. If your data disk is not available at boot time, your {{% gl Device %}}
   will likely hang instead of booting. An easy way to determine what to add to ``/etc/fstab``
   comes courtesy of the Arch Linux install scripts:

   ```
   % sudo pacman -S arch-install-scripts
   % genfstab /
   ```

1. Compare the output of this script, with the content of ``/etc/fstab``. Ignore the lines
   that start with a ``#``. You will likely find a single line that's different. Add this
   line to the end of ``/etc/fstab``. It probably looks something like this:

   ```
   /dev/sdb2     /ubos     btrfs     rw,relatime,space_cache,subvolid=5,subvol=/     0 0
   ```

1. Reboot and check that the data disk is property mounted.

1. Generate a snapper configuration so UBOS can automatically create disk snapshots when
   an update is executed:

   ```
   % sudo snapper -c ubos create-config -t ubos-default /ubos
   ```

### If you have Apps and data on your Device already:

This takes the following steps:

1. Boot your {{% gl Device %}}.

1. Backup all data on your {{% gl Device %}} with ``ubos-admin backup`` and store the backup
   file on a disk that you then remove from the {{% gl Device %}} before continuing. Just to
   be safe :-)

1. Disable all system services that access your ``/ubos`` directory. Which services that
   are depend highly on what {{% gls App %}} you currently run on the {{% gl Device %}}.
   You can find all running services with:

   ```
   % systemctl
   ```

   To find processes that access ``/ubos``, you can use ``lsof``. Most importantly,
   make sure no databases are running:

   ```
   % sudo systemctl stop mysqld postgresql
   ```

1. Attach your big data disk to the {{% gl Device %}}.

1. Identify which block device corresponds to your data disk. This is easiest by executing
   ``lsblk`` once before you attach the disk, and again right after. The change in
   output tells you the name of the block device, such as ``/dev/sdb``.

1. Make sure your data disk is formatted with either ``ext4`` or ``btrfs``. We recommend
   ``btrfs`` as UBOS takes advantage of copy-on-write features, thereby saving disk space
   and speeding up some operations. You can use your entire disk, or just one partition.

1. Move your old ``/ubos`` out of the way, and create a new one, as root:

   ```
   % sudo su
   # mv /ubos /ubos.too-small
   # mkdir /ubos
   ```

1. Mount your data disk at ``/ubos`` by executing:

   ```
   % sudo mount /dev/sdb2 /ubos/
   ```

1. Update ``/etc/fstab`` so that the disk will be automatically mounted after reboots.
   This is important. If your data disk is not available at boot time, your {{% gl Device %}}
   will likely hang instead of booting. An easy way to determine what to add to ``/etc/fstab``
   comes courtesy of the Arch Linux install scripts:

   ```
   % sudo pacman -S arch-install-scripts
   % genfstab /
   ```

1. Compare the output of this script, with the content of ``/etc/fstab``. Ignore the lines
   that start with a ``#``. You will likely find a single line that's different. Add this
   line to the end of ``/etc/fstab``. It probably looks something like this:

   ```
   /dev/sdb2     /ubos     btrfs     rw,relatime,space_cache,subvolid=5,subvol=/     0 0
   ```

1. Copy your data over, as root:

   ```
   % sudo su
   # cp -a /ubos.too-small/* /ubos
   ```

1. Reboot and check that the data disk is property mounted and all
   {{% gls App %}} are functional again.

1. Delete ``/ubos.too-small``

1. Generate a snapper configuration so UBOS can automatically create disk snapshots when
   an update is executed:

   ```
   % sudo snapper -c ubos create-config -t ubos-default /ubos
   ```
