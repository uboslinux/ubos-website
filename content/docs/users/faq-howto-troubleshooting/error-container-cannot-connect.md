---
title: Cannot connect to the public internet from a UBOS container
---

A variety of things can be the root cause of that, and we don't have a full list.
Chances are that your host operating system is not correctly configured for networking
containers. Here is a list of things to check:

1. On your host, a new network interface is generated just for the UBOS container. Using:

   ```
   % ip addr
   ```

   check that such an interface appears when you create the container, and it
   has a suitable IP address such as ``10.0.0.1``. If not, check that you are running
   ``systemd-networkd`` on the host with a suitable configuration file.

1. In your UBOS container, using:

   ```
   % ip addr
   ```

   make sure your container has a corresponding IP address such as ``10.0.0.2`` on an
   interface called ``host0@ifX`` for some value of ``X``.
   If your interface ``host0@ifX`` does not have an IP address, try ``ip dev set host0 up``.
   There seem to be some combinations of systemd versions between host and container in which
   the ``host0`` interface in the container does not automatically come up.

1. Test that you can ping the container from the host, and the host from the container with
   a command such as:

   ```
   % ping 10.0.0.1
   ```

   If you can't and both host and container have correct IP addresses,
   make sure your host does not run a firewall that prevents the communication from
   happening.

1. If the container can communicate with the host, and the host with the public internet,
   but the container cannot communicate with the public internet, chances are that
   some of the involved network interfaces aren't forwarding packets. This is common because
   most Linux distros deactivate packet forwarding by default. The simplest way to
   globally switch on packet forwarding on the host is to execute, on the host:

   ```
   % sudo sysctl net.ipv4.ip_forward=1
   ```

   If this fixes the problem, you can make it permanent by telling systemd about it
   with a configuration file such as ``/etc/systemd/network/wired.network``
   with content:

   ```
   [Match]
   Name=en*

   [Network]
   DHCP=ipv4
   IPForward=1
   ```

   You may have a file like that already, except for the ``IPForward=1`` statement.

1. In your container, try to connect to some well-known IP address, like:

    ```
    % ping 8.8.8.8
   ```

    If you can connect, check DNS, with something like:

    ```
    % dig ubos.net
    ```
