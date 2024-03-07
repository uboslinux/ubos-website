---
title: Problems with "IPv6 Packet Filtering Framework"
---

If you run UBOS in a container, and during boot, you get a message that says
"Failed to start IPv6 Packet Filtering Framework", or if one of the failed services is
``ip6tables``, chances are that your host operating system does not have IPv6 enabled.

Usually, that requires you to manually load the respective kernel extension. If your
host operating system is Arch Linux, simply execute, in the host:

```
% sudo modprobe ip6_tables
```

and reboot your container.

To make this permanent, create file ``/etc/modules-load.d/ip6_tables.conf`` with the
following single line of content:

```
ip6_tables
```

and have systemd pick it up by executing:

```
% sudo systemctl restart systemd-modules-load
```

