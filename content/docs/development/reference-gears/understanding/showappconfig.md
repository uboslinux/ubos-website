---
title: "Command: ubos-admin showappconfig"
---

## Running

To see the supported options, invoke ``ubos-admin showappconfig --help``.

If invoked as ``root``, all available information available can be printed. If
invoked as a non-``root` user, credential information (such as passwords and
TLS keys) are not printed.

## Understanding

This command lists information about one single {{% gl AppConfiguration %}}
on this {{% gl Device %}}.

This command looks for the correct {{% gl Site_JSON %}} file for the specified
{{% gl AppConfiguration %}}, and prints it in various formats and levels of
detail, as specified in the command-line options.

By default, the output is intended for human consumptions, but JSON output is supported
as well.

## See also:

* {{% pageref "/docs/operation/ubos-admin.md" %}}
* {{% pageref listsites.md %}}
* {{% pageref showsite.md %}}

