---
title: "Command: ubos-admin undeploy"
---

## Running

To see the supported options, invoke ``ubos-admin undeploy --help``.

This command must be run as root (``sudo ubos-admin undeploy``).

## Understanding

Assuming the {{% gl Site %}} to be undeployed exists, UBOS will perform the
following steps:

1. The {{% gl Site %}} will be suspended, and the frontpage will be replaced with a
   "site not found" message.

1. If a backup was requested, the backup will be created.

1. All {{% gls App %}} and {{% gls Accessory %}} at the {{% gl Site %}} will be
   undeployed. For each of them, the {{% gl UBOS_Manifest %}} is processed. For each of
   the {{% gls Role %}} in each {{% gl UBOS_Manifest %}}, each of the {{% gls AppConfigItem %}}
   is undeployed: files and directories are deleted, databases "dropped" and
   and scripts run. The {{% gls Role %}} are processed in the reverse sequence of
   deployment (i.e. from frontend to backend, so that, for example, at the time the
   Apache {{% gl Role %}} is processed, the MySQL database is still available.

{{% note %}}
All data of all the {{% gls App %}} and {{% gls Accessory %}} deployed at
the {{% gl Site %}} (but not other {{% gls Site %}} will be discarded.
{{% /note %}}

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref deploy.md %}}
