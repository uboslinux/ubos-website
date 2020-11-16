---
title: Managing Sites and Apps
weight: 60
---

Here is a summary of common tasks when managing the {{% gls Site %}} and
{{% gls App %}} on your {{% gl Device %}}.

## Obtaining information about your Device

### Displaying the overall status of your Device

To show a summary of relevant information about your {{% gl Device %}},
execute:

```
% sudo ubos-admin status
```

### Displaying the currently installed Sites and Apps

To list the currently installed {{% gls Site %}} and {{% gls App %}}, execute:

```
% sudo ubos-admin listsites
```
To find out about options for this command, add ``--help`` as an argument to the command.

### Displaying Site information

To show information about a currently installed {{% gl Site %}} with hostname ``hostname``,
execute:

```
% sudo ubos-admin showsite --hostname <hostname>
```

## Deploying or redeploying a Site with App(s) and Accessory/ies

### Determining the list of available Apps and Accessories:

To see the list of currently available {{% gls App %}} and {{% gls Accessory %}}, execute:

```
% pacman -Sl hl
```

``hl`` stands for "headless", i.e. {{% gls App %}} and {{% gls Accessory %}} that do not
require a display or keyboard attached to the {{% gl Device %}}, such as web apps.

### Interactively creating a new Site with one or more Apps and Accessories

To quickly set up a new {{% gl Site %}} with one or more {{% gls App %}} and
{{% gls Accessory %}}, execute:

```
% sudo ubos-admin createsite
```

To secure this {{% gl Site %}} with SSL/TLS, invoke it instead as

* ``sudo ubos-admin createsite --tls --self-signed`` (auto-generate a
  self-signed certificate)

* ``sudo ubos-admin createsite --tls --letsencrypt`` (auto-provision a
  {{% gl LetsEncrypt %}} certificate). This only works if your {{% gl Device %}}
  is publicly accessible over the internet, and your {{% gl Site %}}'s hostname
  as a corresponding public DNS entry. (See also {{% pageref networking.md %}})

* ``sudo ubos-admin createsite --tls`` (enter key and certificate files
  manually).

## Undeploying one or more Sites

{{% warning %}}
Undeploying one or more {{% gls Site %}} will irrevocably destroy all
data managed by the {{% gls App %}} and {{% gls Accessory %}} of those
{{% gls Site %}}.

Make sure you do not accidentally undeploy the wrong {{% gl Site %}},
and always make backups first (see {{% pageref backup.md %}}).
{{% /warning %}}

### Undeploying a single Site

To undeploy a {{% gl Site %}} with hostname ``<hostname>`` after making
a backup to file ``backup.ubos-backup`` first, execute:

```
% sudo ubos-admin undeploy --backuptofile backup.ubos-backup --hostname <hostname>
```

### Undeploying all Sites on a Device

To undeploy all {{% gls Site %}} currently deployed on a {{% gl Device %}} at
the same time, after making a backup to file ``backup.ubos-backup`` first, execute:

```
% sudo ubos-admin undeploy --backuptofile backup.ubos-backup --all
```

Use with care.

## Updating your Device

To update all code on your {{% gl Device %}} to the most recent UBOS version,
execute:

```
% sudo ubos-admin update
```

{{% note %}}
You are advised to read {{% pageref "/releases/" %}} first.
{{% /note %}}

## Performing backups

To create an all-in-one backup of all {{% gls Site %}} currently deployed
on your {{% gl Device %}} to local file ``backup.ubos-backup``, execute:

```
% sudo ubos-admin backup --backuptofile backup.ubos-backup
```

To back up a single {{% gl Site %}} with hostname ``<hostname>`` currently deployed
on your {{% gl Device %}} to local file ``backup.ubos-backup``, execute:

```
% sudo ubos-admin backup --backuptofile backup.ubos-backup --hostname <hostname>
```
