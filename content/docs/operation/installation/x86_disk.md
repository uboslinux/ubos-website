---
title: Run UBOS on a PC (64bit)
weight: 10
---

To install UBOS on a PC's hard drive, first create a UBOS boot stick as described
in {{% pageref x86_bootstick.md %}}. Boot your PC with that boot stick, and
log on as ``root``. Then:

1. Make sure you have an internet connection. You can check with:

   ```
   % ip addr
   ```

1. Identify the hard drive that you would like to install UBOS on. UBOS supports
   several configurations (see below). In the simplest case, your PC has only
   one hard drive, and you will wipe that hard drive and install UBOS instead.

   Often, the name of your hard drive is ``/dev/sda``. To find the list of
   available drives, execute:

   ```
   % lsblk
   ```

1. To install, execute:

   ```
   % sudo ubos-install /dev/sda
   ```

   {{< warning >}}
   Make sure you get the device name right, otherwise you might accidentally destroy
   the data on some other hard drive!
   {{< /warning >}}

   {{< warning >}}
   Also make sure your hard drive does not contain any valuable data; it will be
   mercilessly overwritten.
   {{< /warning >}}

1. When complete, execute:

   ```
   % sudo systemctl reboot
   ```

   and remove your boot stick. UBOS should now be booting from the disk to which
   you installed it. If not, check your BIOS settings.

1. If your screen goes blank during the boot and doesn't come back on, please refer to
   {{% pageref "/docs/operation/faq-howto-troubleshooting/error-boot-pc-blank-screen.md" %}}.

1. When the boot process is finished, log in as user ``root``.
   For password, see {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-root.md" %}}.

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take a few minutes.
   To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

   To speed up the process, generate lots of random activity, such as looking through the
   file system, and typing lots on the keyboard. You only need to do that once, on the
   first boot.

   To speed up the key generation process, at the potential loss of some entropy,
   execute:

   ```
   % sudo systemctl start haveged
   ```

1. Check that your PC has acquired an IP address:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/operation/firstsite.md" %}}.

## Alternate configurations

If you have two hard drives and would like to use them in a RAID1-style configuration
("duplicate data so one drive can fail"), simply add the second device name to
the ``ubos-install`` command:

```
% sudo ubos-install /dev/sda /dev/sdb
```

If you do not want to erase your entire hard drive, but instead want to install UBOS
on a partition, you can specify the partition device name instead of the drive device
name. For details, refer to

```
% ubos-install --help
```
