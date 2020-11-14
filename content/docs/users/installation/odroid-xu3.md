---
title: Run UBOS on ODROID-XU3, ODROID-XU4, ODROID-HC1 or ODROID-HC2
weight: 210
---

You can run UBOS on the ODROID devices of the XU3/XU4 family, which currently include:

* [ODROID-HC2](https://www.hardkernel.com/shop/odroid-hc2-home-cloud-two/)

* [ODROID-XU4](https://www.hardkernel.com/shop/odroid-xu4-special-price/)

by downloading an image, writing it to an SD card, and booting your ODROID device with that card.
(Alternatively you can keep running your existing Linux distro on your ODROID device, and
run UBOS in a Linux container. This is described in {{% pageref arm7h_container.md %}}.)

Note that ODROID offers a variety of devices with a variety of rather different processors.
The instructions on this page are unlikely to work on any other ODROID devices than the ones
listed here.

1. Download a UBOS boot image from the {{% gl Depot %}}.
   Images for the ODROID-XU3/XU4 family are at
   [depot.ubos.net/green/armv7h/images](http://depot.ubos.net/green/armv7h/images).
   Look for a file named ``ubos_green_armv7h-odroid-xu3_LATEST.img.xz``.

1. Optionally, you may now verify that your image downloaded correctly by following
   {{% pageref verifying.md %}}.

1. Uncompress the downloaded file. This depends on your operating system, but might be as
   easy as double-clicking it, or executing

   ```
   % sudo xz -d ubos_green_armv7h-odroid-xu3_LATEST.img.xz
   ```

   on the command line.

1. Write this image file "raw" to an SD card appropriate for your ODROID device. This
   operation depends on your operating system:

   * {{% pageref "/docs/users/writing-image/windows.md" %}}

   * {{% pageref "/docs/users/writing-image/macos.md" %}}

   * {{% pageref "/docs/users/writing-image/linux.md" %}}

1. Create a {{% gl UBOS_Staff %}} by following the instructions
   {{% pageref "/docs/users/shepherd-staff.md" here %}} if you haven't already. This is
   required for {{% gls Device %}} that don't have video, because UBOS does not permit
   login over the network with a publicly known password. Instead, the {{% gl UBOS_Staff %}}
   mechanism allows you to use an SSH key pair that only you have access to.

1. Remove the SD card and insert it into your ODROID device. Insert the {{% gl UBOS_Staff %}}
   into a USB port of your ODROID device.

1. Connect Ethernet to your ODROID device and your Ethernet network.

1. Connect the power supply to your ODROID device.

1. There isn't any indication when the boot process has finished, so you may want to
   simply wait for, say, 10 minutes. Wait longer if your {{% gl UBOS_Staff %}} also
   contains {{% gls Site_Template %}}.

1. Log into your ODROID device over the network as described in
   {{% pageref "/docs/users/shepherd-staff.md" %}}.

1. Wait until UBOS is ready. To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/users/firstsite.md" %}}.
