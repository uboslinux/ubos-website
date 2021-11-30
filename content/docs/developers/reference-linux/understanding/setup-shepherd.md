---
title: "Command: ubos-admin setup-shepherd"
---

## Running

To see the supported options, invoke ``ubos-admin setup-shepherd --help``.

This command must be run as root (``sudo ubos-admin setup-shepherd``).

## Understanding

This command makes it easier to set up a UBOS {{% gl Shepherd %}} account
without using the {{% gl UBOS_Staff %}}. This may be advantageous in some
situations such as when running UBOS in a Linux container.

This command:

* creates the ``shepherd`` account if it does not exist yetand gives it
  system administration capabilities to be invoked via ``sudo``.

* If one or more public ``ssh`` keys are provided, either adds or replaces them on
  the ``shepherd`` account so the user can log in over the
  network (``~shepherd/.ssh/authorized_keys``).

## See also:

* {{% pageref "/docs/administrators/ubos-admin.md" %}}
