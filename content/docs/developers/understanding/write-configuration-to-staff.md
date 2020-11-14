---
title: "Command: ubos-admin write-configuration-to-staff"
---

## Running

To see the supported options, invoke ``ubos-admin write-configuration-to-staff --help``.

This command must be run as root (``sudo ubos-admin writ-configuration-to-staff``).

## Understanding

This command will attempt to write the device's current configuration to an attached
{{% gl UBOS_Staff %}}.

Based on the provided options, the command may write to a particular USB device, or to
attempt to automatically determine which attached USB device is a suitable
{{% gl UBOS_Staff %}}.

The following information is currently written to the UBOS staff:

* in directory ``flock/<hostid>/ssh``, file ``ssh_host_key.pub`` will contain the
  device's SSH host key, where ``<hostid>`` is the device's host id (i.e. the fingerprint
  of the device's public GPG key)

* the {{% gls Site_JSON %}} files of the {{% gls Sites %}} currently deployed
  on the {{% gl Device %}}.

* system logs of the {{% gl Device %}} that can be helpful for off-device
  debugging of issues with the UBOS {{% gl Device %}}.

Additional information may be written to the UBOS staff in the future.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref read-configuration-from-staff.md %}}
