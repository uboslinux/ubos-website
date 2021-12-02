---
title: Differences between the ubos-target container and a typical UBOS production system
---

The `ubos-target` container
is very similar to a typical UBOS production system, on either virtualized
or physical hardware.

The main differences are:

## `btrfs` file system

UBOS production systems take advantage of the `btrfs` filesystem, such as
to create file system snapshots during system administration operations with
`ubos-admin`. Docker provides its own filesystem, and so these features are
not available.

**Impact LOW:** As an {{% gl app %}} or {{% gl accessory %}} developer, this should not
impact you at all, as your code is unlikely to depend on specific filesystem
features.

## Unsigned packages

The `ubos-target` container allows you to install {{% gls package %}}
that are not digitally signed. This is not permitted on production systems.

**Impact LOW:** It makes your life easier as a developer, and does not impact
the user.

## Networking

Docker performs its own networking, with complex port forwarding setups,
firewall rules and the like. Those are different on UBOS production systems.

**Impact HIGH:** if your {{% gl app %}} or {{% gl accessory %}} communicates on ports
other than port 80 (HTTP) and 443 (HTTPS), you must test your software
on a non-Docker system before releasing it.

Specifically, requesting UBOS to
{{% pageref "/docs/developers/reference-linux/open-extra-ports.md" "open up extra ports" %}}
cannot be tested in a Docker container, and must be tested outside of Docker.
