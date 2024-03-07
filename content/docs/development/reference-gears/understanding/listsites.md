---
title: "Command: ubos-admin listsites"
---

## Running

To see the supported options, invoke ``ubos-admin listsites --help``.

If invoked as ``root``, all available information available can be printed. If
invoked as a non-``root` user, credential information (such as passwords and
TLS keys) are not printed.

## Understanding

This command iterates over all {{% gl Site_JSON %}} files for all
{{% gls Site %}} currently deployed on the {{% gl Device %}}, and prints
them in various formats and levels of detail, as specified in the
command-line options.

By default, the output is intended for human consumptions, but JSON output
is supported as well.

## See also:

* {{% pageref "/docs/operation/ubos-admin.md" %}}
* {{% pageref showappconfig.md %}}
* {{% pageref showsite.md %}}

