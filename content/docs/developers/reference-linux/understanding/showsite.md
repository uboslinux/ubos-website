---
title: "Command: ubos-admin showsite"
---

## Running

To see the supported options, invoke ``ubos-admin showsite --help``.

If invoked as ``root``, all available information available can be printed. If
invoked as a non-``root` user, credential information (such as passwords and
TLS keys) are not printed.

## Understanding

This command lists information about one single {{% gl Site %}} on this
{{% gl Device %}}.

This command looks for the correct {{% gl Site_JSON %}} file for the specified
{{% gl Site %}}, and prints it in various formats and levels of detail, as
specified in the command-line options.

By default, the output is intended for human consumptions, but JSON output is supported
as well.

## See also:

* {{% pageref "/docs/administrators/ubos-admin.md" %}}
* {{% pageref listsites.md %}}
* {{% pageref showappconfig.md %}}
