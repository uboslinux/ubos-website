---
title: "Command: ubos-admin backup"
---

## Running

To see the supported options, invoke ``ubos-admin backup --help``.

This command must be run as root (``sudo ubos-admin backup``).

## Understanding

There are many variations of this command. Regardless of which variation of the command is
used, UBOS generally performs the following actions:

* It suspends the {{% gl Site %}} or {{% gls Site %}} affected by the backup, and temporarily
  replaces them with a placeholder page.

* For each of the {{% gls App %}} and {{% gls Accessory %}} affected by the
  backup, UBOS will examine the corresponding {{% gl UBOS_Manifest %}} and look for
  {{% gls AppConfigItem %}} that have the following fields:

  ```
  "retentionpolicy" : "keep",
  "retentionbucket" : "name"
  ```

  Each of the {{% gls AppConfigItem %}} with these two fields will be backed
  up. All other {{% gls AppConfigItem %}} will be ignored for the purposes of backup.

* The actual backup performed depends on the type of {{% gl AppConfigItem %}}. For
  example, a MySQL database will be dumped, and the resulting dump file will be
  added to the backup.

* The individually exported items, and certain meta-data are assembled in a
  {{% pageref "../backup-format.md" "UBOS backup" %}} file.

* UBOS resumes the {{% gl Site %}} or {{% gls Site %}} affacted by the backup, and removes
  the placeholder page.

* If the user requested encryption of the backup, the entire backup file will be
  encrypted with GPG.

* Depending on the data transfer protocol specified, the resulting file will either be
  moved into the desired location on the local device, or transferred over the network
  to a remote host with the specified host and parameters.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref backupinfo.md %}}
* {{% pageref list-data-transfer-protocols.md %}}
* {{% pageref restore.md %}}
