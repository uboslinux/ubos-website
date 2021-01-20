---
title: Testing your App in a UBOS container running on the Arch Linux development host
weight: 50
---

In addition to your development host running Arch Linux, you need a device or virtual
machine running UBOS on which you can test your developed code. Obviously, you can use
any of the supported UBOS platforms (be that physical devices or virtual devices) for that
purpose.

But in our experience, development is particularly productive if you run UBOS in a
Linux container on the same Arch Linux development machine. If you run btrfs on your
Arch Linux development machine, getting a clean UBOS target can be done in just a few
seconds, which is great for reproducible installs and tests.

To run a UBOS container on a Arch development machine, follow these steps:

1. Download UBOS for a Linux container on your machine architecture (such as x86_64)
   as described in {{% pageref "/docs/users/installation/" %}}.

1. Unpack this file into a btrfs subvolume. Neither btrfs nor subvolumes are required,
   but they make things faster while taking up less disk space. Assuming you picked
   ``~/ubos-development`` as a place for your subvolume:

   ```
   % cd ~
   % sudo btrfs subvolume create ubos-development
   % cd ubos-development
   % sudo tar xfJ <path-to-downloaded-UBOS-archive>
   ```

1. Run both IPv4 and IPv6 based ``iptables`` on your host, otherwise UBOS cannot set up its
   own firewall and the UBOS container will boot into a ``degraded`` state. If you aren't
   already doing this, on the host:

   ```
   % [[ -e /etc/iptables/iptables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/iptables.rules
   % [[ -e /etc/iptables/ip6tables.rules ]] || sudo cp /etc/iptables/empty.rules /etc/iptables/ip6tables.rules
   % sudo systemctl enable iptables ip6tables
   % sudo systemctl start iptables ip6tables
   ```

   This will not actually perform any firewall functionality (the ruleset is empty), but
   it will allow the UBOS container to set up its own firewall.

1. Boot the container using ``systemd-nspawn``. (Other Linux container tools may provide
   similar functionality.) The following invocation may be advantageous:

   ```
   % cd ~
   % sudo systemd-nspawn -b -n -D ubos-development -M ubos-development --bind /home
   ```

   This will set up a named container called ``ubos-development``, using the directory
   you uncompressed UBOS into as the root filesystem, and set up a private, DHCP-enabled and
   masquerading-enabled network on your host, so Arch development machine and UBOS container
   can communicate, and UBOS can reach the internet. It will also mount your home directory
   tree from the development host into the UBOS container, so access to the development files becomes easy.

   In addition, you may want to specify ``-x`` in the command. This will use an ephemeral
   copy of ``~/ubos-development`` as the root filesystem for the container, which will
   disappear when the container quits. Thus getting a clean new UBOS target is as simple
   as restarting the container.

1. When the boot process is finished, log in as user ``root``
   (for password, see the {{% pageref "/docs/users/faq-howto-troubleshooting/howto-root.md" %}}).

1. Your container should automatically acquire an IP address. You can check with:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed.

1. Pick a hostname that you will use to run your {{% gls App %}} at in the container, for example
   ``testhost``. Add this and the container's IP address to the Arch development machine's
   ``/etc/hosts``, so you can easily reach the container with a virtual hostname.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. Relax the rules usually requiring valid package signatures for all packages on UBOS.
   This allows you to install your own packages without having to sign them. In the
   UBOS container, in file ``/etc/pacman.conf``, change this line:

   ```
   LocalFileSigLevel = Required TrustedOnly
   ```

   to this:

   ```
   LocalFileSigLevel = Optional
   ```

1. Now you can create your code on the Arch development host and package it with
   ``makepkg`` (depending on your situation, ``makepkg -C -f -d`` may be the version
   you want). This will produce a package file easily recognized by the pattern ``.pkg``
   in its filename. For example, it might be ``example-0.1-any.pkg.tar.xz``.

1. In the UBOS container, install that package with:

   ```
   % sudo pacman -U example-0.1-any-pkg.tar.xz
   ```

   before you continue deploying your {{% gl App %}}, {{% gl Accessory %}} or
   {{% gl Site %}} with ``ubos-admin createsite`` or ``ubos-admin deploy``:
   it obviously cannot be found yet in the UBOS {{% gl Depot %}} as you are
   still developing it.
