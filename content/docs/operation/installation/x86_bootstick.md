---
title: Run UBOS from a boot stick on a PC (64bit)
weight: 20
---

You can install UBOS on a USB flash drive, and boot a standard PC directly from it.
This will leave your PC's hard drive unchanged and lets you try out UBOS easily.

A 16GB USB flash drive is recommended.

Follow these steps:

1. Download a UBOS boot image from the {{% gl Depot %}}.
   Images for x86_64 are at
   [depot.ubosfiles.net/green/x86_64/images/index.html](http://depot.ubosfiles.net/green/x86_64/images/index.html).
   Look for a file named ``ubos_green_x64_64-pc_LATEST.img.xz``.

1. Optionally, you may now verify that your image downloaded correctly by following
   {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-verify-image.md" %}}.

1. Uncompress the downloaded file. This depends on your operating system, but might be as
   easy as double-clicking it, or executing

   ```
   % xz -d ubos_green_x86_64-pc_LATEST.img.xz
   ```

   on the command line.

1. Write this image file "raw" to a USB flash drive. This
   operation depends on your operating system:

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/windows.md" %}}

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/macos.md" %}}

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/linux.md" %}}

1. Remove the USB flash drive, insert it into a PC that is currently off, and boot
   that PC from the USB flash drive. Depending on that computer's BIOS, you may have to
   set its BIOS to allow booting from USB first, or change the boot order, so the
   computer actually boots from the USB flash drive and not some other drive. Some BIOSs
   are less than friendly about this and hide this setting in very strange places, so
   you may need to experiment some.

1. Connect Ethernet to your PC and your Ethernet network. If you do not have Ethernet
   on your PC, you can set up WiFi later as described in
   {{% pageref "/docs/operation/networking.md" %}}.

1. When the boot process is finished, log in as user ``root`` from the attached keyboard
   and monitor. For password, see {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-root.md" %}}.

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
