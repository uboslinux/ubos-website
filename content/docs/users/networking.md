---
title: Setting up networking and DNS
weight: 20
---

## Introduction

UBOS can be run on many different hardware configurations. For example, a {{% gl Device %}}
may or may not have an Ethernet port; or it may have several. It may or may not have WiFi,
which may be on board or be a separate USB dongle. Networks that a {{% gl Device %}}
connects to might also be very different, from typical home networks to virtual networks
on host machines running UBOS in Linux containers.

Because of all these differences, networking for Linux server devices is usually complex to
set up and requires substantial expertise.

With UBOS, as usual, we try to simplify things. We do this by pre-defining some common
{{% gls Network_Configuration %}}, and automatically install the one most likely to work "out
of the box" for a new {{% gl Device %}} of a given class without further configuration. But
if you wish to use the {{% gl Device %}} in a different setting, we provide a single command
to switch to a different {{% gl Network_Configuration %}}.

Unlike other network management tools, UBOS {{% gls Network_Configuration %}} manage all necessary
layers of the networking stack at the same time including:

* individual network interfaces such as Ethernet interfaces

* IP addresses

* DHCP

* DNS on the local network

* zeroconf/mDNS

* Firewall

* Masquerading

* open ports for applications.

This works for wired (Ethernet) and wireless (WiFi) connections.

## Currently available Network Configurations

The following {{% gls Network_Configuration %}} are currently available:

### Network configuration: ``client``

For most {{% gls Device_Class %}}, this is the default {{% gl Network_Configuration %}} after
UBOS installation.

If your {{% gl Device %}} has an Ethernet port, and you connect it to your Ethernet
network, the {{% gl Device %}} will automatically connect.

If your {{% gl Device %}} has more than one network interface, it should not matter
which you use.

In this mode:

* **network interfaces**: All network interfaces are active, and looking to obtain an
  IP address, default gateway and DNS server information via
  [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol).

* **mDNS**: The {{% gl Device %}} will advertise itself on all network interfaces.

* **ports**: Application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from all network interfaces.

* **ssh**: ssh connections are accepted on all network interfaces.

* **firewall**: All other ports are firewalled.

If you'd like to have a predictable IP address for your {{% gl Device %}} in this
{{% gl Network_Configuration %}}, we recommend that you configure your DHCP server to
always hand out the same IP address to your {{% gl Device %}}. This tends to be an easier,
and typically more maintainable process than maintaining static IP addresses on all the
{{% gls Device %}} on your network. For example, depending on the model
of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.

* Look for your UBOS device, and note its MAC address.

* In some part of the administrative interface of your home router, you may be
  able to assign a consistent IP address for the device with this MAC address.

### Network configuration: ``standalone``

This {{% gl Network_Configuration %}} is useful to set up a network that is disconnected
from the public internet. In this configuration, the {{% gl Device %}} assumes the role
of network manager and manages the network by running a DHCP server, and a DNS server.

Other computers connected to the {{% gl Device %}} will be able to receive an IP address
and use network services as if they were connected to a typical home network, but
without upstream connection to the public internet.

If your {{% gl Device %}} has more than one network interface, UBOS will create separate
subnets for each network interface.

In this mode:

* **network interfaces**: All network interfaces are active and have a static IP address
  assigned. Other connected computers can obtain IP address, default gateway and DNS server
  information from a DHCP server and a DNS server running on the {{% gl Device %}}.

* **mDNS**: The {{% gl Device %}} will advertise itself on all interfaces.

* **ports**: application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from all interfaces.

* **ssh**: ssh connections are accepted on all interfaces.

* **firewall**: All other ports are firewalled.

### Network configuration: ``gateway``

This {{% gl Network_Configuration %}} was created to make it easy to use UBOS for home routers.
In this configuration, UBOS will connect to the public internet via broadband through
one network interface, and obtain an IP address from the ISP via DHCP. All other network
interfaces will have statically allocated, private IP addresses that connect to the
public internet via Network Address Translation (NAT, also known as masquerading).

This configuration requires the {{% gl Device %}} to have at least two network interfaces:
one for the upstream connection to the public internet via the ISP, and one for the
local network. Devices connecting to the local network can obtain local IP addresses
from the UBOS device via DHCP. The {{% gl Device %}} also provides DNS for the local network,
with delegation to the ISP's DNS server.

If the {{% gl Device %}} has more than two network interfaces, additional interfaces will be
created as separate local networks on different subnets.

{{% gls Site %}} running on the {{% gl Device %}} are accessible from the local network
("downstream") but not from the public internet ("upstream").

In this mode:

* **network interfaces**: All network interfaces are active.

  * The first ("upstream") interface (which one that is depends on the hardware; trial and
    error helps) connects to the upstream broadband connection. It obtains IP address,
    default gateway and upstream DNS server information via DHCP.

  * All other ("downstream") interfaces have static IP addresses assigned. Computers connecting
    to those interfaces can obtain a local area network IP address, default gateway and DNS server
    information from a DHCP server and a DNS server running on the {{% gl Device %}}.

* **masquerade**: Computers connected to a "downstream" interface are masqueraded behind the
  IP address of the "upstream" interface.

* **mDNS**: The {{% gl Device %}} will advertise itself on the "downstream" interfaces only.

* **ports**: Application-level ports (such as HTTP and HTTPS ports 80 and 443) will be
  accessible from computers connected to the "downstream" interfaces only.

* **ssh**: ssh connections are accepted on all interfaces.

* **firewall**: All parts other than ``ssh`` are firewalled on the "upstream" interface.
  Application ports are accessible from the "downstream" interfaces.

### Network configuration: ``public-gateway``

This {{% gl Network_Configuration %}} is identical to ``gateway``, except that {{% gls Site %}}
running on the {{% gl Device %}} are accessible both from the local network ("downstream") and
from the public internet ("upstream").

### Network configuration: ``container``

This {{% gl Network_Configuration %}} is used by UBOS when run in a Linux container started by
``systemd-nspawn``, by Docker or the like. It is very similar to ``client`` but there are
no mDNS advertisements.

### Network configuration: ``off``

In this network configuration, UBOS has turned off all networking. This is useful as an
emergency setting.

### Network configuration: ``espressobin``

This ESPRESSObin-specific {{% gl Network_Configuration %}} is like ``gateway``.
It configures the Ethernet port closest to the USB 3 port (the blue USB port) on the
ESPRESSObin to be the ``upstream`` network interface, and the other network interfaces to
be ``downstream``.

## mDNS hostnames

By default, {{% gls Device %}} announce themselves on the local-area network with the
following names:

<table>
 <thead>
  <tr>
   <th>UBOS installed on:</th>
   <th>mDNS hostname:</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td>PC</td>
   <td><code>ubos-pc.local</code></td>
  </tr>
  <tr>
   <td>Virtual PC in VirtualBox</td>
   <td><code>ubos-vbox-pc.local</code></td>
  </tr>
  <tr>
   <td>Raspberry Pi Zero or 1</td>
   <td><code>ubos-raspberry-pi.local</code></td>
  </tr>
  <tr>
   <td>Raspberry Pi 2 or 3</td>
   <td><code>ubos-raspberry-pi2.local</code></td>
  </tr>
  <tr>
   <td>Raspberry Pi 4</td>
   <td><code>ubos-raspberry-pi4.local</code></td>
  </tr>
  <tr>
   <td>ODROID XU-3, XU-4, HC-1 or HC-2</td>
   <td><code>ubos-odroid-xu3.local</code></td>
  </tr>
  <tr>
   <td>ESPRESSObin</td>
   <td><code>ubos-espressobin.local</code></td>
  </tr>
 </tbody>
</table>

So for example, if you run UBOS on a Raspberry Pi, after the Raspberry Pi has booted,
you should be able to access your Raspberry Pi on your local network at
``http://ubos-raspberry-pi.local/``.

Access should work on all operating systems and types of devices, **except on older versions
of Windows** if you do not have iTunes installed. (Yes, this sounds strange. Basically, Microsoft
in the past has not supported mDNS, but Apple does, and Apple adds it to your Windows PC as
soon as you install iTunes. Apple calls this feature Bonjour.) So if you are unlucky enough to
run an older version of Windows, please install iTunes there and mDNS resolution should work.

The advantage of using these mDNS hostnames is that no DNS setup is required, and you do
not need to assign a static IP address to your {{% gl Device %}}.

The disadvantage of using these hostnames is that they only work on the local network,
and that you cannot run more than one {{% gl Site %}} on the same {{% gl Device %}}. There
may also be collisions if you run more than one {{% gl Device %}} of the same type on the
same network.

If you wish to change your {{% gl Device %}}'s mDNS hostname, change its Linux hostname, and restart
the Avahi daemon. Assuming you would like the new name to be ``mydevice``, you can do this
by executing the following commands as ``root``:

```
% hostname mydevice
% hostname > /etc/hostname
% sudo systemctl restart avahi-daemon
```

## Non-mDNS (regular) hostnames

If you would like to use more than one {{% gl Site %}} on the same {{% gl Device %}},
or you would like to use a hostname of your choosing (say, ``family.example.com``) you
need to set up DNS yourself. This can sometimes be performed in the administration interface of
your home router.

For example, depending on the model of your home router, you may be able to do this:

* Log into the administrative interface of your home router, and look for a page
  that lists all currently connected devices on your network.

* Look for your {{% gl Device %}}, and note its MAC address.

* In some part of the administrative interface of your home router, you may be
  able to assign a consistent hostname for the device with this MAC address.

Unfortunately, this entirely depends on the features of your home router, and is outside
of the control of UBOS.

## Persistence of network configuration settings

Once a {{gl Network_Configuration %}} is set with:

```
% sudo ubos-admin setnetconfig <name>
```

it will survive a reboot. Furthermore, when a {{% gl Network_Configuration %}}
is restored -- for example because temporarily another {{% gl Network_Configuration %}}
was activated -- the previous settings will be restored as much as possible. Consider this
sequence:

```
% sudo ubos-admin setnetconfig standalone
% sudo ubos-admin setnetconfig off
% sudo ubos-admin setnetconfig standalone
```

In the ``standalone`` {{% gl Network_Configuration %}}, UBOS assigns static IP addresses to all
network interfaces found. Which IP address is assigned to which network interface is
basically random. However, it would be desirable if the same IP address was assigned to the same
interface when the ``standalone`` network configuration was restored after temporarily
being ``off``. UBOS accomplishes this by saving the actual assignments in file
``/etc/ubos/netconfig-standalone.json`` (replace ``standalone`` with the name of the
network configuration). If such a file exists, UBOS will restore its settings as much
as possible.

This enables a user not scared of editing a JSON file to override the standard settings
of a particular {{% gl Network_Configuration %}}. For example, if a {{% gl Device %}} has
two network interfaces and is used in the ``client`` network configuration, by editing
``/etc/ubos/netconfig-client.json`` and executing ``ubos-admin setnetconfig client`` again,
the user could, for example, keep one of those interfaces off, or have different ports open.

To display information about the most recently set {{% gl Network_Configuration %}}:

```
% sudo ubos-admin shownetconfig
```

## Extra DHCP and DNS configuration settings

UBOS uses ``dnsmasq`` ([home page](http://www.thekelleys.org.uk/dnsmasq/doc.html))
to issue DHCP leases and manage DNS on the local network. UBOS makes it
straightforward for you to add your own settings to the ones managed by UBOS:

* Settings generated and managed by UBOS are in directory ``/etc/dnsmasq.ubos.d``.

* Add your settings to directory ``/etc/dnsmasq.d``. You can use any file name,
  as long as it ends in ``.conf``.

For details, please refer to the ``dnsmasq`` documentation.

For example: you could use this setup to implement a DHCP "white list" so only devices
that are know are allowed to obtain an IP address, which in turn will be the same every
time the same device connects to the network.

## External Dynamic DNS

If your {{% gl Device %}} can be reached over the public internet, such as if it acts as a
broadband router, it may be advantageous to run Dynamic DNS: this provides a consistent
DNS hostname for the {{% gl Device %}}, even if the internet service provider changes the
{{% gl Device %}}'s IP address from time to time.

For that purpose, UBOS includes the ``ddclient`` package, which supports a broad range of
paid and free dynamic DNS providers. To set it up, first install the package:

```
% sudo pacman -S ddclient
```

Then, as root, edit ``/etc/ddclient/ddclient.conf`` with the settings for your dynamic DNS provider.
Finally, run ``ddclient`` as a daemon:

```
% sudo systemctl enable --now ddclient.service
```

This is described in more detail on the
[Arch Linux Wiki](https://wiki.archlinux.org/index.php/Dynamic_DNS
