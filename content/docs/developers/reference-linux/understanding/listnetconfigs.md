---
title: "Command: ubos-admin listnetconfigs"
---

## Running

To see the supported options, invoke ``ubos-admin listnetconfigs --help``.

## Understanding

In UBOS, a {{% gl Network_Configuration %}} is a set of active
network interfaces, their configuration, and the configuration of associated services
such as DNS, firewall, and the like.

Some of the network configurations are pre-installed on all UBOS {{% gls Device %}}.
Others come in other packages which need to be installed first. Only some of the
installed {{% gls Network_Configuration %}} may be applicable to the {{% gl Device %}}
on which they were installed: for example, a {{% gl Network_Configuration %}} that
implements a router requires the {{% gl Device %}} to have at least two network
interfaces, which the {{% gl Device %}} may or may not have; this may also change
over time as network cards are added or removed.

This command iterates through the {{% gls Network_Configuration %}} defined in Perl package
``UBOS::Networking::NetConfigs``, determines which of those are applicable to the
current {{% gl Device %}} in the current configuration, and prints them.
Adding the ``--all`` parameter, all {{% gls Network_Configuration %}} will be printed,
regardless of whether they appear to applicable to the current {{% gl Device %}}.

## See also:

* {{% pageref "/docs/administrators/ubos-admin.md" %}}
* {{% pageref setnetconfig.md %}}
* {{% pageref shownetconfig.md %}}
* The set of currently implemented {{% gls Network_Configuration %}} is
  documented in {{% pageref "/docs/administrators/networking.md" %}}.
