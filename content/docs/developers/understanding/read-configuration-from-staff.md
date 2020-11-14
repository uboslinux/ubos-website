---
title: "Command: ubos-admin read-configuration-from-staff"
---

## Running

To see the supported options, invoke ``ubos-admin read-configuration-from-staff --help``.

This command must be run as root (``sudo ubos-admin read-configuration-from-staff``).

## Understanding

This command will attempt to read an attached {{% gl UBOS_Staff %}}
and configure the device based on information found there.

Based on the provided options, the command may read from a particular USB device,
or attempt to automatically determine which attached USB device is a suitable
{{% gl UBOS_Staff %}} device.

This command is also performed automatically upon boot, unless disabled by setting
``ubos.readstaffonboot`` to false like this in file ``/etc/ubos/config.json``:

```
"ubos" : {
     "readstaffonboot" : false
 }
```

The following information is currently read from the {{% gl UBOS_Staff %}}:

* from directory ``shepherd/ssh``, file ``id_rsa.pub`` will be used as the
  an authorized key for remote ssh access by the ``shepherd`` Linux user
  on the {{% gl Device %}}.

* from directory ``site-templates``: {{% gls Site_JSON %}} files to be
  deployed on the {{% gl Device %}}.

Additional information may be read from the {{% gl UBOS_Staff %}} in the future.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref write-configuration-to-staff.md %}}
