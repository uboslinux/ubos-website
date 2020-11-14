---
title: Run UBOS in a Linux container on a PC (64bit)
weight: 410
---

If you already run Linux on a 64bit PC, you can run UBOS in a Linux container with
``systemd-nspawn``. This allows you to try out UBOS without having to do a bare
metal installation. The only requirement is that your Linux machine runs ``systemd``
in a reasonably recent version.

To do so:

1. Download a UBOS container image from the {{% gl Depot %}}.
   Images for x86_64 containers are at
   [depot.ubos.net/green/x86_64/images](http://depot.ubos.net/green/x86_64/images).
   Look for a file named ``ubos_green_x86_64-container_LATEST.tar.xz``.

1. Optionally, you may now verify that your image downloaded correctly by following
   {{% pageref verifying.md %}}.

1. Uncompress and unpack the downloaded file into a suitable directory by executing:

   ```
   % mkdir ubos
   % sudo tar -x -J -C ubos -f ubos_green_x86_64-container_LATEST.tar.xz
   ```

   on the Linux command line.

   If you are running btrfs as your filesystem, you may want to create a subvolume and
   unpack into that subvolume instead, as ``systemd-nspawn`` is btrfs-aware and that can
   speed up things and save some disk space. However, use of btrfs is optional.

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

1. Boot the container. ``systemd-nspawn`` has a wide variety of options, in particular
   for how to set up networking. A private network, as we do it here, is one simple
   option, but you may want to choose a different option, depending on your needs:

   ```
   % sudo systemd-nspawn --boot --network-veth --machine ubos --directory ubos
   ```

1. When the boot process is finished, log in as user ``root``
   (for password, see {{% pageref "/docs/users/faq-howto-troubleshooting/howto-root.md" %}}).

1. Now: wait. UBOS needs to generate a few cryptographic keys before it is ready to use
   and initialize a few other things on the first boot. That might take 5 or 10 minutes
   on slower platforms. To determine whether UBOS ready, execute:

   ```
   % systemctl is-system-running
   ```

   The container takes entropy from the host computer, so make sure the host Linux system
   provides enough. Depending your Linux distro, you may be able to generate more by
   typing on the keyboard, moving the mouse, generating hard drive activity etc. You can
   also run:

   ```
   % sudo systemctl start haveged
   ```

   on your host (not container).

1. Your container should automatically acquire an IP address. You can check with:

   ```
   % ip addr
   ```

   Make sure you are connected to the internet before attempting to proceed. If you
   have difficulties reaching the internet from your container, consult
   {{% pageref "/docs/users/faq-howto-troubleshooting/" %}}.

1. Update UBOS to the latest and greatest:

   ```
   % sudo ubos-admin update
   ```

1. You are now ready for {{% pageref "/docs/users/firstsite.md" %}}.
   Note that with the private networking setup described on this page, you will only be able
   to access {{% gls App %}} installed in your UBOS container from the host computer. If you like
   to access them from anywhere else, you either need to give your container a non-private
   IP address, or port forward from the host to the container.

1. To shut down your container, either:

   * hit ^] three times, or
   * in a separate shell, execute ``sudo machinectl poweroff ubos``
