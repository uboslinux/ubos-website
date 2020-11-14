---
title: Network Configuration
plural: Network Configurations
summary: A set of active network interfaces, their configuration and associated services.
---

In UBOS, a {{% gl Network_Configuration %}} is a set of active network interfaces,
their configuration, and the configuration of associated services such as DNS,
firewall, and the like.

UBOS packages these up into discrete configurations, so it becomes easy to
switch between configurations without having to reconfigure several services
manually.

For example, the {{% gl Network_Configuration %}} ``public-gateway`` configures
a {{% gl Device %}} as a router, including firewall, masqerading, local DNS server
and the like.
