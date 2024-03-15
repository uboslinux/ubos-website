---
title: Run UBOS on Raspberry Pi 5
weight: 130
---

You can run UBOS on your Raspberry Pi 5 by downloading an image, writing it to
an SD card, and booting your Raspberry Pi with that card. (Alternatively you can keep
running your existing Linux distro on your Raspberry Pi, and run UBOS in a Linux container.
This is described in {{% pageref aarch64_container.md %}}.)

If you are not sure which model you have, consult
[this page](http://www.raspberrypi.org/products/).

Raspberry Pi models older than the Pi 5 are no longer supported, although it may work
on the Pi 4.

{{% note %}}
Some monitor configurations may go black half-way through the boot process. UBOS still
boots, though, and you can access it via `ssh` and the {{% gl ubos_staff %}}.
{{% /note %}}

To install UBOS on a Raspberry Pi, either on a micro-SD card or external USB disk:

1. Download a UBOS boot image from the {{% gl Depot %}}.
   Images for the Raspberry Pi are at
   [depot.ubosfiles.net/green/aarch64/images/index.html](http://depot.ubosfiles.net/green/aarch64/images/index.html).
   Look for a file named ``ubos_green_aarch64-rpi5_LATEST.img.xz``.

1. Optionally, you may now verify that your image downloaded correctly by following
   {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-verify-image.md" %}}.

1. Uncompress the downloaded file. This depends on your operating system, but might be as
   easy as double-clicking it, or executing

   ```
   % xz -d ubos_green_aarch64-rpi5_LATEST.img.xz
   ```

   on the command line.

1. Write this image file "raw" to an SD card appropriate for your Raspberry Pi. This
   operation depends on your operating system:

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/windows.md" %}}

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/macos.md" %}}

   * {{% pageref "/docs/operation/faq-howto-troubleshooting/writing-image/linux.md" %}}

1. On first boot, it is recommended you have a monitor and keyboard connected to your
   Raspberry Pi. If this is impractical, create a {{% gl UBOS_Staff %}} by following
   {{% pageref "/docs/operation/shepherd-staff.md" %}}, so you can securely log in over the
   network without the need for monitor or keyboard.

1. Remove the SD card and insert it into your Raspberry Pi. If you created a
   {{% gl UBOS_Staff %}}, insert it into a USB port.

1. Connect Ethernet to your Raspberry Pi and your Ethernet network.

1. Plug in the Raspberry Pi's USB power.

1. When the boot process is finished, log in as user ``root`` from the attached keyboard
   and monitor. For password, see {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-root.md" %}}.
   If you used a {{% gl UBOS_Staff %}}, you can log in over the network instead as described in
   {{% pageref "/docs/operation/shepherd-staff.md" %}}.

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes.
   To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

1. Check that your Raspberry Pi has acquired an IP address:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/operation/firstsite.md" %}}.
