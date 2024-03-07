---
title: UBOS Backup format
weight: 70
---

## The Idea

The UBOS Backup File Format defines how to store, in a single file, all data and meta-data
necessary to reconstruct the installation of one or more {{% gls App %}} at one or more
{{% gls Site %}}. This supports use cases such as backup, restore, archival, checkpointing,
QA and many others.

This file format can be defined once in an application-independent manner, and thus can be
used by all {{% gls App %}}.

## Philosophy

We use ZIP. We chose it over tar because ZIP has better random-access capabilities; tar
is intended to be read sequentially.

We store full meta-data for the {{% gls Site %}} and {{% gls AppConfiguration %}} whose
data is stored in the backup. This allows users to restore {{% gls Site %}} and/or
{{% gls AppConfiguration %}} without having to provide additional information.

Note that the individual items in the ZIP file generally do not directly map to files and
directories on a file system as explained below.

Files in this format generally use extension ``.ubos-backup``. Any of the entries in the
ZIP file may be deflated (aka compressed) according to standard ZIP conventions.

When an encrypted backup is desired, the entire ``.ubos-backup`` file is encrypted with
GPG, and be convention, the file extension becomes ``.ubos-backup.gpg``.

## Meta-data

``filetype``
: This file contains a fixed string to identify this ZIP file as
  a UBOS backup file in version 1.

  Fixed string: ``UBOS::Backup::ZipFileBackup;v1``

``starttime``
: This file contains the (starting) time at which this backup file was being created, in
  the UTC time zone in RFC 3339 format.

  Example: ``2014-12-31T23:59:01.234Z``

``sites/``
: This directory contains the {{% gl Site_JSON %}} files of all {{% gls Site %}} that have been
  backed up to this file.

  For example:

``sites/s1111111111222222222233333333334444444444.json``
: The {{% gl Site_JSON %}} file for a {{% gl Site %}} with {{% gl SiteId %}}
  ``s111111111122222222223333333333334444444444``, which has been
  backed up to this backup file. The name of the file must be the {{% gl SiteId %}} of the
  {{% gl Site %}}, plus the ``.json`` postfix. This file is only present for those {{% gls Site %}}
  that have been backed up as a whole to this backup file.

  If additional {{% gls Site %}} have been backed up to this file, their
  {{% gl Site_JSON %}} files would also be found in this directory.

``installables/``
: This directory contains the {{% gl UBOS_Manifest %}} JSON files of all {{% gls App %}} and
  {{% gls Accessory %}} of all the {{% gls Site %}} in the backup, in the version they were
  running at the time the backup was created. This helps to reconcile version differences at
  the time of restore.

``installables/gladiwashere-php-mysql.json``
: The {{% gl UBOS_Manifest %}} file of the ``gladiwashere-php-mysql`` example {{% gl App %}}.
  The name of this file must be the {{% gl App %}}'s or {{% gl Accessory %}}'s
  {{% gl Package %}} name, plus the ``.json`` postfix.

## In-ZIP hierarchical structure

All other content of the ZIP file is structured:

* first by {{% gl AppConfiguration %}},

* then by {{% gl Package %}},

* then by {{% gl Role %}},

* and finally by {{% gl Retention_Bucket %}}.

This structure is similar to the structure of {{% gl Site JSON %}} files and
{{% gl UBOS_Manifest %}} files. This allows a backup file to contain the data
of several installations of the same application without conflicts (for example, two
Wordpress installations at different virtual hosts or relative path name).

The file may contain {{% gls AppConfiguration %}} that are not part of a
{{% gl Site %}}; i.e. there is no {{% gl Site_JSON %}} in the ``sites/`` directory
discussed above that mentions them. This occurs when only an {{% gl AppConfiguration %}}
instead of an entire {{% gl Site %}} was backed up to this backup file.

The ``appconfigs/`` directory is structured as follows:

``appconfigs/``
: Parent directory of all the backed-up data.

``appconfigs/a4444444444333333333322222222221111111111.json``
: The fragment of the {{% gl Site_JSON %}} file that belongs to this
  {{% gl AppConfiguration %}}. This fragment is present here regardless of whether the
  full {{% gl Site_JSON %}} file is present in the ``sites/`` directory discussed above.

``appconfigs/a4444444444333333333322222222221111111111/``
: This directory contains data which was backed up from the {{% gl AppConfiguration %}} whose
  {{% gl AppConfigId %}} has value ``a4444444444333333333322222222221111111111``. To determine
  which {{% gl Site %}} this {{% gl AppConfiguration %}} belonged to at the time of backup,
  consult the {{% gl Site_JSON %}} files above. However, it may be that only the
  {{% gl AppConfiguration %}} was backed up, not the entire {{% gl Site %}}, so there may not
  be a {{% gl Site_JSON %}} file that refers to this {{% gl AppConfiguration %}}.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere-php-mysql/``
: This directory contains data which was backed up from the ``gladiwashere-php-mysql`` example
  {{% gl App %}} at this {{% gl AppConfiguration %}}. The name of this directory is the
  {{% gl Package %}} name of the {{% gl App %}} or {{% gl Accessory %}} whose data
  is backed up in this directory.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere-php-mysql/apache2/``
: This directory contains data which was backed up from {{% gl Role %}} ``apache2`` of this
  {{% gl App %}} or {{% gl Accessory %}} at this {{% gl AppConfiguration %}}. Any
  {{% gl Role %}} may have a section here.

``appconfigs/a4444444444333333333322222222221111111111/gladiwashere-php-mysql/apache2/uploads``
: The name of the {{% gl Retention_Bucket %}} that was backed up. This is the same as specified in
  the {{% gl UBOS_Manifest %}} file by the {{% gl App %}} or {{% gl Accessory %}}.
  The toy app ``gladiwashere-php-mysql`` doesn't actually define an ``uploads``
  {{% gl Retention_Bucket %}}, but if it did, the relevant part of the {{% gl UBOS_Manifest %}}
  would look like this:

```
{
    ...
    "retention"       : "backup",
    "retentionbucket" : "uploads"
}
```

Depending on the type of item that is being backed up, this may be a file or a directory.

## Content storage

This section documents how content of various types is represented in a backup file.
Additional types of content may be defined in the future.

### File and directory content

Assume that a directory
``/ubos/http/sites/s1111111111222222222233333333334444444444/blog/uploads`` of some web
{{% gl App %}} needs to be backed up. Let's assume that this directory belongs to an {{% gl App %}}
that has been installed at {{% gl Context_Path %}} ``/blog`` of some {{% gl Site %}}
({{% gl App %}} {{% gl Package %}} ``myapp``, {{% gl SiteId %}}
``s1111111111222222222233333333334444444444``, {{% gl AppConfigId %}}
``a4444444444333333333322222222221111111111``).

Let's also assume this {{% gl App %}} has declared in its {{% gl UBOS_Manifest %}}
the directory {{% gl AppConfigItem %}} for the ``apache2`` {{% gl Role %}} like this :

```
{
    "type"            : "directory",
    "name"            : "uploads",
    "retention"       : "backup",
    "retentionbucket" : "uploadsdir"
    ...
}
```

Then, the recursive directory tree starting with root directory
``/ubos/http/sites/s1111111111222222222233333333334444444444/blog/uploads`` will be backed up to
``appconfigs/a4444444444333333333322222222221111111111/myapp/apache2/uploadsdir`` in the
backup file.

Note that the filename in the ZIP file comes from the ``retentionbucket`` field in the
{{% gl UBOS_Manifest %}}, and not from the name field or the name of the {{% gl App %}} or
{{% gl Accessory %}}. That way, the names of files and directories can be easily changed from
one version of the {{% gl App %}} or {{% gl Accessory %}} to the next without impacting
future or old backups.

### MySQL database content

Assume that the {{% gl UBOS_Manifest %}} of some {{% gl App %}} or {{% gl Accessory %}}
declares a database as one of its {{% gls AppConfigItem %}} in the ``mysql`` {{% gl Role %}}
({{% gl App %}} or {{% gl Accessory %}} {{% gl Package %}} ``myapp``, {{% gl SiteId %}}
``s1111111111222222222233333333334444444444``, {{% gl AppConfigId %}}
``a4444444444333333333322222222221111111111``).

Let's also assume this {{% gl App %}} has declared in its {{% gl UBOS_Manifest %}}
that it wishes the database to be backed up, like this:

```
{
    "type"            : "database",
    "name"            : "maindb",
    "retention"       : "backup",
    "retentionbucket" : "maindb.mysqldump",
    ...
}
```

Then, upon backup, the content of the MySQL database will be exported by UBOS with the
``mysqldump`` tool to a file called ``maindb.mysqldump`` in directory
``appconfigs/a4444444444333333333322222222221111111111/myapp/mysql/`` in the backup
file.

Note that the filename in the backup file comes from the ``retentionbucket`` field in the
{{% gl UBOS_Manifest %}}, not from the name field or the name of the {{% gl App %}}
nor from the actual MySQL database name in the running {{% gl App %}}.

### Postgresql database content

Assume that the {{% gl UBOS_Manifest %}} of some {{% gl App %}} or {{% gl Accessory %}}
declares a database as one of its {{% gls AppConfigItem %}} in the ``postgresql`` {{% gl Role %}}
({{% gl App %}} or {{% gl Accessory %}} {{% gl Package %}} ``myapp``, {{% gl SiteId %}}
``s1111111111222222222233333333334444444444``, {{% gl AppConfigId %}}
``a4444444444333333333322222222221111111111``).

Let's also assume this {{% gl App %}} has declared in its {{% gl UBOS_Manifest %}}
that it wishes the database to be backed up, like this:

```
{
    "type"            : "database",
    "name"            : "maindb",
    "retention"       : "backup",
    "retentionbucket" : "maindb.dump",
    ...
}
```

Then, upon backup, the content of the Postgresql database will be exported by UBOS with the
``pg_dump`` tool to a file called ``maindb.dump`` in directory
``appconfigs/a4444444444333333333322222222221111111111/myapp/postgresql/`` in the backup
file.

Note that the filename in the backup file comes from the ``retentionbucket`` field in the
{{% gl UBOS_Manifest %}}, not from the name field or the name of the {{% gl App %}}
nor from the actual Postgresql database name in the running {{% gl App %}}.
