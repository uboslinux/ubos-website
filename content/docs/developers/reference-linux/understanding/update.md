---
title: "Command: ubos-admin update"
---

## Running

To see the supported options, invoke ``ubos-admin update --help``.

This command must be run as root (``sudo ubos-admin update``).

## Understanding

Invoking this command will:

1. Suspend all currently deployed {{% gls App %}} and {{% gls Accessory %}} on them, and
   replace them with a placeholder "Upgrade in progress" web page.

1. Create a temporary backup of all data of all currently deployed {{% gls App %}} and {{% gls Accessory %}}
   on all {{% gls Site %}} on the {{% gl Device %}}.

1. Undeploy all {{% gls Site %}}, including all the {{% gls App %}} and {{% gls Accessory %}}
   on the {{% gl Device %}}.

1. If a backup was requested, the backup will be exported and transferred to the
   specified location.

1. Upgrade the code on the device. There are two modes:

   * If one or more ``--pkgfile <pkgfile>`` arguments were given, only the specified
     package files will be installed. This internally uses ``pacman -U <pkgfile>``.

   * If no ``--pkgfile`` argument was given, UBOS will download and install all available
     upgraded packages on the the {{% gl Device %}}. This includes operating-system packages,
     middleware packages and application packages. This step is equivalent to (and in fact
     internally uses) ``pacman -Syu``.

1. Apply a heuristic whether or not the {{% gl Device %}} should be rebooted. For example, if the
   Linux kernel has been upgraded, a reboot is typically necessary. This heuristic can
   be overridden with command-line flags to ``ubos-admin update``. If the {{% gl Device %}} is to
   be rebooted, it will be rebooted in this step. The remaining steps will be executed
   automatically after the reboot. This is performed by writing a file with after-boot
   commands that will be executed as soon as the rebooting process is complete.

1. Restore all {{% gls Site %}} with all {{% gls App %}} and {{% gls Accessory %}} from the previously
   made backup, but with the most recent code version.

1. Run any necessary data migrations by invoking the various "update" methods in the
   relevant {{% gls AppConfigItem %}}. This is described in more detail in
   {{% pageref restore.md %}}.

1. Replaces the placeholder pages with the applications again.

The individual steps are largely the same as documented in {{% pageref backup.md %}},
{{% pageref undeploy.md %}}, and {{% pageref restore.md %}}.

Note that UBOS never upgrades "in-place" but performs a new installation of each {{% gl App %}}
again, with subsequent restore-from-backup. This makes it less likely that "leftover" files
get in the way of smooth operation of the new version of the {{% gl App %}}.

## See also:

* {{% pageref "/docs/administrators/ubos-admin.md" %}}
* {{% pageref backup.md %}}
* {{% pageref deploy.md %}}
* {{% pageref restore.md %}}
* {{% pageref undeploy.md %}}
