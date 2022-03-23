---
title: Backup and restore
weight: 70
---

## UBOS backup files

To make backup and restore easy, UBOS uses standard ZIP files, with certain additional
conventions. To distinguish them from arbitrary other ZIP files, UBOS backup files
typically use the extension ``.ubos-backup``.

With a single command, you can backup all the data of all the {{% gls App %}} installed
on your {{% gl Device %}} to a single UBOS backup file. Or, you can use separate backup
files for each {{% gl Site %}} on your {{% gls Device %}}. You can also back up just a
single {{% gl App %}} at a {{% gl Site %}} to a backup file.

Similarly, given a ``.ubos-backup`` file, you can restore an entire {{% gl Site %}} (same
hostname, same TLS credentials, same {{% gls App %}} with all of their data at the same
context paths) or or only parts. You can also change hostnames and context paths during
restore.

UBOS keeps track inside the backup file what {{% gls App %}} you backed up, and how they
were configured at the time they were backed up. This makes UBOS backup files essentially
self-documenting, and makes it possible that backups can be interpreted even at some
considerable time in the future: all information required to restore an {{% gl App %}} to
the state is was in at the time the backup was created is contained in the UBOS backup file.

The details of the UBOS backup format are
{{% pageref "/docs/developers/reference-linux/backup-format.md" "documented for developers" %}}.

## Creating a local backup

To create a local backup of all the data of all the {{% gls App %}} on the {{% gl Device %}}
and save that data to file ``<backupfile>``, execute:

```
% sudo ubos-admin backup --tobackupfile <backupfile>
```

If you like UBOS to pick a suitable filename that includes the current date, only specify the
directory:

```
% sudo ubos-admin backup --tobackupdir ~
```

This will create a backup file containing all installed {{% gls App %}} at all
{{% gls Site %}} on the local host.

If you run more than one {{% gl Site %}} on a {{% gl Device %}}, to create a local
backup of all the data of only the {{% gls App %}} and {{% gls Accessory %}} of one
particular {{% gl Site %}} with {{% gl SiteId %}} ``<siteid>``, and to save that backup
to file ``<backupfile>``, execute:

```
% sudo ubos-admin backup --siteid <siteid> --tobackupfile <backupfile>
```
To determine the correct ``<siteid>``, use ``ubos-admin listsites --detail``.


Alternatively, you can specify the hostname of the {{% gl Site %}}:

```
% sudo ubos-admin backup --hostname <hostname> --tobackupfile <backupfile>
```

If you run more than one {{% gl App %}} at a {{% gl Site %}}, to create a local
backup of all the data of only a single installed {{% gl App %}} and
its {{% gl Accessory %}} with {{% gl AppConfigId %}} ``<appconfigid>``, and to
save that backup to file ``<backupfile>``, execute:

```
% sudo ubos-admin backup --appconfigid <appconfigid> --tobackupfile <backupfile>
```

To determine the correct ``<appconfigid>``, use ``ubos-admin listsites --detail``.

If your {{% gl Site %}} uses TLS, and you do not want to store your TLS key material
in the backup, execute the backup command with the ``--notls`` option.

You can also create a backup as a side effect of a ``ubos-admin update`` or
``ubos-admin undeploy`` operation: simply add option ``--backup <backupfile>`` to
the command.

##  Creating a backup that is stored on a remote host

You can use backup destinations that contain a {{% gl Data_Transfer_Protocol %}} as
part of their URL. Here are some examples:

* ``file:/tmp/my.ubos-backup``: the local file ``/tmp/my.ubos-backup``. For convenience,
  you don't need the prefix ``file:``.

* ``https://example.com/my.ubos-backup``: use HTTPS to HTTP "POST" the backup file to
  this URL. (This requires you have to have suitable software running at ``example.com``
  that knows what to do with the arriving file!)

* ``s3://mybucket/my.ubos-backup``: the file ``my.ubos-backup`` in Amazon Web Services'
  Simple Storage Service (S3), bucket ``mybucket``. This requires the ``amazons3`` package
  to be installed.

* ``rsync+ssh://user@example.com/my.ubos-backup``: the file ``my.ubos-backup`` uploaded
  to host ``example.com`` as user ``user``, using the ``rsync`` protocol over ``ssh``.
  This requires the ``ubos-datatransfer-rsync`` package to be installed.

You can find all {{% gls Data_Transfer_Protocol %}} currently available on your
{{% gl Device %}} by executing:

```
% ubos-admin list-data-transfer-protocols
```

This will also show available options for these {{% gls Data_Transfer_Protocol %}}.

Each of those {{% gls Data_Transfer_Protocol %}} may have its own options and particularities.
For example, if you use ``ftp``, you may or may not have to turn on "passive mode" (which
is a command-line option shown with ``ubos-admin list-data-transfer-protocols``). Some
may require usernames, passwords or other credentials. ``ubos-admin backup`` will either
complain that a necessary option was not provided, or interactively ask you for it. For
some {{% gls Data_Transfer_Protocol %}}, like ``ftp`` for example, it may not be obvious what
options are needed for your particular situation; try out different ones until it works.

UBOS will, by default, remember the options and credentials you used for backing up
to remote locations. This makes it easier to run the same backup on a regular basis
-- something we'd like to encourage.

## Example: creating a backup that is stored on Amazon S3

As an example, let's see how UBOS can automatically upload a backup file to your account
at Amazon Web Services and store it in its Simple Storage Service (S3).

```
% sudo pacman -S amazons3
```

This makes the ``s3`` {{% gl Data_Transfer_Protocol %}} available.

You need to have an existing "bucket" on S3 that you are permitted to write to. Let's
assume it is called ``mybucket``. Then, you could invoke the backup to S3 as follows:

```
% sudo ubos-admin backup --backuptodir s3://mybucket
```

or:

```
% sudo ubos-admin backup --backuptofile s3://mybucket/my.ubos-backup
```

When you invoke this command for the first time, it will ask you for the
necessary credential information so it can store the backup on your account
at Amazon Web Services. This credential information will be stored on your
{{% gl Device %}}, so you do not need to enter it every time you run a backup.

Specifically, you need to have the Amazon "Access Key ID" and the Amazon
"Secret Access Key" for an AWS user that is permitted to create and
write the S3 bucket that you specified. Creating this may involve the following
steps:

* Sign up for an Amazon Web Services (AWS) account.

* In AWS, create an suitable Identity and Access Management (IAM) user,
  e.g. ``mybackupuser``. This is a user that will only use "programmatic"
  access.

* Add the needed permissions to this user by creating a policy, such as:

  * ``HeadBucket``
  * ``ListBucket``
  * ``CreateBucket``
  * ``PutObject``.

* Create an "Access Key ID" and "Secret Access Key" for that user. Store both
  of them securely, as Amazon will not show you the Secret Access Key again.

## Example: creating a backup that is uploaded via rsync over ssh

If you wanted to back up via rsync over ssh, for example to a home NAS device,
first install the ``ubos-datatransfer-rsync`` package:

```
% sudo pacman -S ubos-datatransfer-rsync
```

This makes the ``rsync+ssh`` {{% gl Data_Transfer_Protocol %}} available.

Then you need to have a rsync-over-ssh endpoint (e.g. on your NAS) that can be
accessed with a SSH keypair; password-based authentication is not supported.

Then you can perform the backup with a command such as:

```
% sudo ubos-admin backup --idfile <privatekeyfile> --backuptodir rsync+ssh://<server>/directory
```

where ``<privatekeyfile>`` is the SSH private key to be used.

## Encrypting a backup

To automatically encrypt a backup before delivering it to its final (local or remote)
location, specify ``--encryptid <id>`` as an argument to ``ubos-admin backup``. UBOS
will look in the GPG keychain of the ``shepherd`` user for a GPG public key with
identifier ``<id>``, and encrypt the backup file with it.

If you generate the GPG keypair somewhere else than as ``shepherd`` on your UBOS
{{% gl Device %}}, importing the public key into the ``shepherd``'s key ring can be
as simple as executing:

```
% gpg --import
```

and copy-pasting the public key into the terminal, followed by a ``^D`` (for end of file).

Note: Please make sure you understand public and private keys before you do this.
Backups are useless if they are encrypted and you can't decrypt them when you need to!
In particular, if you make backups to be able to recover your data if your UBOS
{{% gl Device %}} is lost, stolen, or destroyed, be sure you have the private key needed
to decrypt your backups in a safe place that won't be lost, stolen or destroyed at the
same time!

## Determining what a backup file contains

To determine the contents of a ``.ubos-backup`` file, execute:

```
% ubos-admin backupinfo --in <backupfile>
```

This will show information about the backup, such as when it was created,
as well as which {{% gls Site %}}, {{% gls App %}} and {{% gls Accessory %}}
were backed up.

## Restoring from backup

You can restore data either by specifying a local ``.ubos-backup`` file
(using the ``--in <backupfile>`` command-line options) or by specifying an
http or https URL from which the backup file will first be downloaded (using the
``--url <backupurl>`` command-line options). In this section, we will assume
your backup file is local but all commands should work equally with remote
files.

To restore all {{% gls Site %}} with all {{% gls App %}} and {{% gls Accessory %}}
contained in a ``.ubos-backup`` file, execute:

```
% sudo ubos-admin restore --in <backupfile>
```

This command will refuse to work if restoring the backup would cause a
conflict with a {{% gl Site %}} that is already installed. Possible conflicts include
the following:

* a currently deployed {{% gl Site %}} runs at the same hostname as one to be restored;

* a currently deployed {{% gl Site %}} has the same {{% gl SiteId %}} as one to be restored;

* a currently deployed {{% gl App %}} has the same {{% gl AppConfigId %}} as one to be restored;

* a currently deployed {{% gl App %}} runs at the same {{% gl Context_Path %}} as one to be restored.

If you wish to restore a previous version of a currently deployed {{% gl Site %}} from
backup, either back up and then undeploy the current {{% gl Site %}} first, or restore
the {{% gl Site %}} at a new hostname and with new identifiers, using the ``--createnew``
options described below.

To restore a {{% gl Site %}} with a certain {{% gl SiteId %}} from a backup file ``<backupfile>``
to the current {{% gl Device %}}, but leave all other {{% gls Site %}} unchanged, specify
the {{% gl SiteId %}}:

```
% sudo ubos-admin restore --siteid <siteid> --in <backupfile>
```

Alternatively, you can use the hostname of the {{% gl Site %}} that was used at the time
of the backup:

```
% sudo ubos-admin restore --hostname <hostname> --in <backupfile>
```

To restore only one {{% gl App %}}, instead of all {{% gls App %}} at a {{% gl Site %}},
specify the {{% gl AppConfigId %}} and the hostname of the {{% gl Site %}} to which the {{% gl App %}}
shall be added:

```
% sudo ubos-admin restore --appconfigid <appconfigid> --tohostname <tohostname> --in <backupfile>
```

Alternatively you can use the {{% gl SiteId %}} of the {{% gl Site %}} to which the
{{% gl App %}} shall be added:

```
% sudo ubos-admin restore --appconfigid <appconfigid> --tositeid <tositeid> --in <backupfile>
```

To copy a {{% gl Site %}} or {{% gl AppConfiguration %}} and use new identifiers and a new hostname,
use one of the following:

```
% sudo ubos-admin restore --siteid <fromsiteid> --createnew --newhostname <newhostname> --in <backupfile>
```

Finally, to replace one or more {{% gls App %}} or {{% gl Accessory %}} with a different one
during restore, use the ``--migratefrom <package>`` and ``--migrateto <package>`` options, such as:

```
% sudo ubos-admin restore --migratefrom owncloud --migrateto nextcloud --in <backupfile>
```

To see the full set of options, invoke:

```
% ubos-admin restore --help
```
