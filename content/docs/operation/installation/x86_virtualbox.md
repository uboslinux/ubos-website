---
title: Run UBOS in a VirtualBox virtual machine (64bit)
weight: 30
---

To run UBOS in a VirtualBox virtual machine on `x86_64`, follow these instructions. Not counting
download times, this should take no more than 10 minutes to set up. These instructions are
the same regardless of the operating system that VirtualBox runs on.

While we don't have separate instructions for VMware, the process should be quite similar.

{{% note %}}
{{% gl linux %}} is a 64bit operating system, for which VirtualBox requires hardware virtualization
support. This is generally available on all reasonably modern processors, but may have to
be switched on in the BIOS first. See the
[VirtualBox documentation](https://www.virtualbox.org/manual/ch10.html#hwvirt).
{{% /note %}}
{{% warning %}}
Running UBOS in a VirtualBox on an ARM computer, such as a Mac with Apple Silicon, is
currently not supported.
{{% /warning %}}

1. [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads) from virtualbox.org
   and install it if you haven't already.

1. Download a UBOS boot image from the {{% gl Depot %}}.
   Images for Virtualbox (64bit) are at
   [depot.ubosfiles.net/green/x86_64/images/index.html](http://depot.ubosfiles.net/green/x86_64/images/index.html).
   Look for a file named ``ubos_green_x86_64-vbox_LATEST.vmdk.xz``.

1. Optionally, you may now verify that your image downloaded correctly by following
   {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-verify-image.md" %}}.

1. Uncompress the downloaded file. This depends on your operating system, but might be as
   easy as double-clicking it, or executing

   ```
   % xz -d ubos_green_x86_64-vbox_LATEST.vmdk.xz
   ```

   on the command line.

1. In VirtualBox, create a new virtual machine:

   * Click "New".

   * Enter a name for the virtual machine, such as "UBOS (green)".
     Select Type: "Linux", and Version: "Other Linux (64 bit)". Click "Continue".

   * Select the amount of RAM you want to give it. 1024MB is a good start, and you can change
     that later. Click "Continue".

   * Select "Use an existing virtual hard drive file" and pick the downloaded boot image file
     in the popup. You may need to select the little icon there to get a file selection dialog.
     Click "Create".

1. By default, VirtualBox will put your virtual machine behind a special VirtualBox NAT on
   your local host. That means you won't be able to access it with a web browser.
   To avoid this, either:

   * Set your networking mode to "bridged": Click on "Network". In the pop-up, select
     tab "Adapter 1", and choose "Bridged Adapter", and in the "Name" field choose the
     host system's network adapter that connects to your Ethernet or Wifi network.
     Click "Ok". (This should work unless your Ethernet or Wifi network isn't willing to
     hand out more than one DHCP address to the same machine; it happens on some tightly
     managed networks). Or:

   * Activate two virtual networking interfaces, one as "NAT", and one as "Host-only Adapter":
     Click on "Network" in the right pane. In the pop-up, first select tab "Adapter 1", and
     choose "NAT". Then, select tab "Adapter 2", make sure that "Enable Network Adapter" is
     checked, and choose "Host-only Adapter". Click "Ok".

1. In the main window, click "Start". The virtual machine should now be booting.

1. When the boot process is finished, log in as user ``root``.
   For password, see {{% pageref "/docs/operation/faq-howto-troubleshooting/howto-root.md" %}}.

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take a few minutes.
   To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

1. If you are on VMWare, the VirtualBox kernel extension is going to fail. This is no cause
   for concern, simply disable it by removing file ``/etc/modules-load.d/virtualbox.conf``.

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes.
   To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

1. Check that your virtual UBOS PC has acquired an IP address:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/operation/firstsite.md" %}}.
