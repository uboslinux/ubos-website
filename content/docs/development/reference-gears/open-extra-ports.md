---
title: Allocating and opening up non-default ports
weight: 60
---

There are two separate issues here:

* making sure that when an {{% gl app %}} needs an extra port,
  the port can be assigned in a way that it does not conflict with
  the port assignment of another {{% gl app %}} on the same
  {{% gl device %}}. Hard-coding the number does not work!
  This is particularly important if more than one
  {{% gl appconfiguration %}} of the same {{% gl app %}} is being run on
  the same {{% gl device %}}: the ports can't be mixed up with each other.

* allowing an {{% gl app %}} to open up a port in the UBOS firewall
  so clients can use it. This may or may not be required for any
  extra port that {{% gl app %}} likes to use, because some of those
  extra ports might only be used by different processes of the same
  {{% gl app %}} to communicate with each other on the installed
  {{% gl device %}}.

So we discuss them separately:

## To allocate AppConfiguration-specific ports

This is handled by {{% gls AppConfigItem %}} of type
``tcpport`` and ``udpport`` as documented in {{% pageref "manifest/roles.md" %}}
of the {{% gl ubos_manifest %}}.

This will allocate a unique port, but not open up the firewall.

## Opening up a port in the UBOS firewall

The UBOS firewall, by default, blocks most traffic and only permits
that traffic that is known to be needed, such as port 80 (HTTP),
port 22 (ssh) or 67 and 68 (DHCP).

If your {{% gl app %}} needs another port, you need to instruct
the UBOS firewall to open it. You do this by creating a file in
``/etc/ubos/open-ports.d/<name>`` where ``<name>`` is the name
of your {{% gl app %}}'s {{% gl package %}}, or the name of that
{{% gl package %}} with the {{% gl appconfigid %}} appended.

This file needs to contain exactly one line per open port. This line
must be ``<PPP>/<PROTO>``, where:

* ``<PPP>`` is the port number you'd like to open;
* ``<PROTO>`` is either `udp` or `tcp`, depending on what you need.

This file will be evaluated every time the UBOS firewall gets reconfigured,
such as when a {{% gl site %}} is newly deployed or reconfigured, or
when the user invokes ``ubos-admin setnetconfig``.

It is usually sufficient to simply include such a file in your {{% gl package %}},
or generate it via the {{% gl ubos_manifest %}},
and UBOS will evaluate it at the right time when your {{% gl app %}} is
first deployed or updates.

## To allocate a single port used by all AppConfigurations of an App

Please get [in touch](/community/) to have your port placed on
this list. The following port numbers are well-known so far:

<table>
 <thead>
  <tr>
   <th>Port</th>
   <th>Protocol</th>
   <th>Name of App or Accessory</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td>6001</td>
   <td>tcp</td>
   <td><code>decko</code></td>
   <td><code>decko-memcached.service</code> listens at this port for all Decko
       instances on this Device.</td>
  </tr>
 </tbody>
</table>
