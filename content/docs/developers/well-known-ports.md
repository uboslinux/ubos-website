---
title: Well-known ports for Apps and Accessories
---

Some apps or accessories need to open up ports, such as:

* externally, e.g. for communications with the users' rich clients

* internally, e.g. so two daemons can communicate.

A further distinction is whether there needs to be:

* one port per {{% gl AppConfiguration %}} (i.e. when the {{% gl App %}} is deployed
  more than once on the same {{% gl Device %}}, each of them needs to have a
  separate port)

* one port shared by all {{% gls AppConfiguration %}} of the same
  {{% gl App %}} on the same {{% gl Device %}}. This is uncommon, but happens if all
  of them can talk to the same instance of a daemon like ``memcached`` without
  conflicts.

## To allocate AppConfiguration-specific ports

This is handled by {{% gls AppConfigItem %}} of type
``tcpport`` and ``udpport`` as documented in {{% pageref "manifest/roles.md" %}}.

## To allocate a single port used by all AppConfigurations of an App

Please get [in touch](https://ubos.net/community/) to have your port placed on
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
