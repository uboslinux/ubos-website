---
title: "Command: ubos-admin restore"
---

## Running

To see the supported options, invoke ``ubos-admin restore --help``.

This command must be run as root (``sudo ubos-admin restore``).

## Understanding

This command:

```
% sudo ubos-admin restore <arguments>
```

supports a number of different use cases:

* Restore all {{% gls Site %}} (including all {{% gls App %}} and {{% gls Accessory %}}
  contained in the provided {{% pageref "../backup-format.md" "UBOS backup file" %}} to
  the same configuration as at the time of when the backup file had been created. This
  includes {{% gls Hostname %}}, {{% gls Context_Path %}}, {{% gls Customization_Point %}},
  and even SSL/TLS keys and certificates (assuming the backup file contains all of those).

* Restore only some {{% gls Site %}} contained in the backup file.

* Restore only some of the {{% gls AppConfiguration %}} of some of the {{% gls Site %}}
  contained in the backup file.

* Restore {{% gls Site %}} or {{% gls AppConfiguration %}} to different hostnames and/or
  context paths than they had been deployed to at the time the backup file had been created.

* Restore an {{% gl AppConfiguration %}} and its data that had been deployed to one
  {{% gl Site %}} at the time the backup file had been created, to a different
  {{% gl Site %}} on the current {{% gl Device %}}.

* Restore an {{% gl AppConfiguration %}} that ran some {{% gl App %}} ``A`` at the time the
  backup file had been created, to an {{% gl AppConfiguration %}} running
  some other {{% gl App %}} ``B`` on the current {{% gl Device %}}. This allows migration
  of data from one {{% gl App %}} to another; however, it assumes that {{% gl App %}} ``B``
  understands what to do with data that comes in the form {{% gl App %}} would have
  expected it.

{{% note %}}
Backups can only be restored to the currently available versions of the required
{{% gls App %}} and {{% gls Accessory %}} on the current {{% gl Device %}}. UBOS does not
support downgrading {{% gls App %}} or {{% gls Accessory %}} to older versions unless
they are the current version on the current {{% gl Device %}}'s {{% gl Release_Channel %}}.
{{% /note %}}

During restore, UBOS generally performs the following actions:

* It examines the meta-data contained in the backup file, to determine
  which {{% gls App %}} and {{% gls Accessory %}} are required to use the to-be-restored
  data.

* It installs the {{% gls Package %}} for the required {{% gls App %}} and {{% gls Accessory %}},
  and their dependencies, unless they are already installed.

* It deploys the relevant {{% gls Site %}}. Depending on the command-line options, this
  may recreate {{% gls Site %}} as they were in the backup file, create an
  entirely new {{% gl Site %}}, or modify an existing {{% gl Site %}}.

* Whenever a new {{% gl Site %}} is created or an existing {{% gl Site %}} is modified,
  UBOS suspends the {{% gl Site %}} and replaces its web interface with a placeholder page.

* UBOS walks through the {{% gl UBOS_Manifest %}} of the involved {{% gls App %}}
  and {{% gls Accessory %}}, and restores each of the {{% gls AppConfigItem %}} whose
  retention fields have been set.

* The actual restore performed depends on the type of {{% gl AppConfigItem %}}. For example,
  a MySQL database will be created and imported, while files and directories are simply
  copied into the right place, potentially adjusting permissions according to the
  {{% gl UBOS_Manifest %}}.

* The ``upgraders`` of the {{% gls App %}} and {{% gls Accessory %}} are run, so the
  imported data can be migrated to the structure needed by the current versions of the
  {{% gls App %}} and {{% gls Accessory %}}. This supports the situation where the backup
  was created with an older version of an {{% gl App %}} or {{% gl Accessory %}} than
  is currently installed on the {{% gl Device %}} and some form of data migration needs
  to be performed before the new version can run.

* The {{% gl Site %}} is resumed, and the placeholder web page is removed.

This command internally uses a plug-in architecture, which allows the support of
alternate backup formats without changing the invocation by the user.

## Restoring to different versions of the App or Accessory

When a backup is restored, it is possible (likely?) that the version of the {{% gl App %}}
or {{% gl Accessory %}} currently available is different (newer) than the version of the
{{% gl App %}} or {{% gl Accessory %}} that ran at the time the backup was created: after
all, likely some time has passed between when a backup was created and when it needs to be
restored.

UBOS itself does not (and in fact cannot) migrate data from old versions of
{{% gls App %}} or {{% gls Accessory %}} to new ones. This is the responsibility of the
{{% gl App %}} or {{% gl Accessory %}} developer. This is what the ``upgraders`` field
in the {{% gl UBOS_Manifest %}} is for: run code that will upgrade the data.

## Renaming retention buckets

Particular care needs to be take when an {{% gl App %}} or {{% gl Accessory %}} changes the
numbers or names of its retention buckets. UBOS matches the content of a bucket by name,
and does NOT restore the content of buckets whose name is not specified in the
{{% gl UBOS_Manifest %}} any more. Conversely, when adding an additional bucket from one
version to another, the {{% gl App %}} or {{% gl Accessory %}} must be tolerant of the
situation that during upgrades or restores, that bucket will be empty as UBOS cannot
restore any data into it.

A good strategy for a developer is to never rename retention buckets.

## Multi-step upgrades

Developers are encouraged to support multi-step upgrades, in which their ``upgrade``
scripts are able to migrate the data from older versions (and not just the most recent
previous version) of their {{% gl App %}} or {{% gl Accessory %}} to the most
recent one. This enables users to restore their data even from older backups.

## See also:

* {{% pageref "/docs/users/ubos-admin.md" %}}
* {{% pageref backup.md %}}
* {{% pageref restore.md %}}
