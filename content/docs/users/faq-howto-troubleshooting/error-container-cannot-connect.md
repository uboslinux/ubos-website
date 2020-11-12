---
title: My UBOS container cannot connect to the network
---

A variety of things can be the root cause of that, and we don't have a full list. To debug,
check on which level of the networking stack the problem occurs, with commands such as:

```
% ip addr
```

If your interface ``host0`` does not have an IP address, try ``ip dev set host0 up``. There
seem to be some combinations of systemd versions between host and container in which the
``host0`` interface in the container does not automatically come up.

If you have an IP address, try to connect to some well-known IP address, like:

```
% ping 8.8.8.8
```

If you can connect, check DNS, with something like:

```
% dig ubos.net
```

Also, make sure your host system performs IP forwarding, such as by creating
file ``/etc/systemd/network/wired.network`` on your host with the following
content:

```
[Match]
Name=en*

[Network]
DHCP=ipv4
IPForward=1
```
