---
title: "Command: ubos-admin list-data-transfer-protocols"
---

## Running

To see the supported options, invoke ``ubos-admin list-data-transfer-protocols --help``.

## Understanding

UBOS supports an open-ended list of "data transfer protocols", implemented as subclasses
of ``UBOS::AbstractDataTransferProtocol``, and found in Perl package
``UBOS::DataTransferProtocols``. Each one knows how to transfer a local file to
a (local, or more likely, remote) destination.

This command discovers which of those data transfer protocols are available on the
{{% gl Device %}} and shows them to the user with some descriptive text.

The same mechanism is used by ``ubos-admin backup`` to determine whether a given
backup destination is valid, and to find the code to run in order to transfer
the backup to the specified location.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref backup.md %}}
