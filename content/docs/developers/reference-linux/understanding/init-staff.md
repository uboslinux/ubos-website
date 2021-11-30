---
title: "Command: ubos-admin init-staff"
---

## Running

To see the supported options, invoke ``ubos-admin init-staff --help``.

This command must be run as root (``sudo ubos-admin init-staff``).

## Understanding

This command turns a USB device into a valid {{% gl UBOS_Staff %}}, optionally
saving information provided as arguments to the command on the {{% gl UBOS_Staff %}}.

Unless given as command-line parameter, a heuristic is used to determine whether
to reformat the USB device before writing to it, so all existing information on
it should assume to be lost after this command is complete.

## See also:

* {{% pageref "/docs/administrators/ubos-admin.md" %}}
