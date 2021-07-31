---
title: "Command: ubos-admin status"
---

## Running

To see the supported options, invoke ``ubos-admin status --help``.

This command must be run as root (``sudo ubos-admin status``).

## Understanding

This command is intended as a general-purpose device status command. Eventually it
will emit "everything that's worth knowing about the state of the device".

It accomplishes this by invoking various Linux system commands, and reading configuration
files according to UBOS conventions.

Command-line flag allow for filtering what information is shown. It supports
JSON output as well.

A problem section lists those pieces of status information that are most
likely to cause problems, if any.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
