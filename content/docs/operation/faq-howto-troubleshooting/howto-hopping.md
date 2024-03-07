---
title: I want to move from one device to another, or from/to the cloud to/from a device
---

Maybe you use UBOS so much, you decided you need run it on a {{% gl device %}} with a
faster processor. Or you want to move your UBOS {{% gls site %}} from your Raspberry Pi
to the cloud. Or maybe the other way around: in either case, you somehow need to
recreate the same configuraiton of {{% gls site %}} and {{% gls app %}} on the
new {{% gl device %}} and transfer all your data.

Other server-based operating systems leave you to your fate and you have to
painstakingly re-install on the new {{% gl device %}} and then figure out how
to move your data. Not so with UBOS. Simply do this:

On your old device, create a {{% pageref "/docs/operation/backup-restore.md" backup %}}
of all your {{% gls site %}} with a command such as:

```
% sudo ubos-admin backup --all --backuptofile all.ubos-backup
```

Then, transfer that file to your new, and blank UBOS {{% gl device %}}. You
do NOT need to install any {{% gls app %}} there, UBOS will do that for you.
Then, on the new {{% gl device %}}, restore the backup, with a command such
as:

```
% sudo ubos-admin restore --in all.ubos-backup``
```

UBOS will restore all your {{% gls site %}} with all your data. Two commands,
(plus transferring the file) is all it took!

We call this "Site hopping" or "Host hopping".

