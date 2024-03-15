---
title: Command reference
weight: 130
---

``ubos-admin`` is the central administration command for UBOS.  When invoked without arguments,
it lists the currently available sub-commands. Note that the list of available sub-commands
may become longer if you install certain extra packages.

To invoke an ``ubos-admin`` sub-command, execute:

```
% sudo ubos-admin <subcommand> <arguments>
```

To obtain help on a particular sub-command, execute:
```
% sudo ubos-admin <subcommand> --help
```

## ``ubos-admin backup``

To create a backup of all {{% gls Site %}} on your {{% gl Device %}} and save
it to ``all.ubos-backup``:

```
% sudo ubos-admin backup --all --backuptofile all.ubos-backup
```

To create a backup of all {{% gls Site %}} on your {{% gl Device %}} and save
it to a file in your home directory letting UBOS choose a timestamped file name:

```
% sudo ubos-admin backup --all --backuptodir ~
```

To create a backup of a single {{% gl Site %}} and save it to a file:

```
% sudo ubos-admin backup --hostname <hostname> --backuptofile <backupfile>
```

or

```
% sudo ubos-admin backup --siteid <siteid> --backuptofile <backupfile>
```

To create a backup or a single {{% gl AppConfiguration %}} at a {{% gl Site %}}
and save it to a file:

```
% sudo ubos-admin backup --appconfigid <siteid> --backuptofile <backupfile>
```

You can determine the {{% gl SiteId %}} or {{% gl AppConfigId %}} with
``ubos-admin listsites``.

To encrypt the backup file as part of the process: add ``--encryptid <id>`` to the
command, where ``<id>`` is the key identifier of a private key in the ``shepherd`` user's
GPG repository.

To automatically upload the created file to a remote host, specify a data transfer protocol,
host and (potentially) user information as part of the destination. To determine the
available data transfer protocols, run ``ubos-admin list-data-transfer-protocols``.

Examples:

* ``scp://user@example.com/foo.ubos-backup`` will upload the file using ``scp`` to host
  ``example.com``, as user ``user``.

* ``s3://bucket/file`` will upload to an Amazon S3 bucket called ``bucket`` and create file
  ``file`` there. This requires that the package ``amazons3`` is installed, and that you
  have permissions to upload to this bucket.

## ``ubos-admin backupinfo``

To determine the content of a ``.ubos-backup`` file:

```
% ubos-admin backupinfo --in <backupfile>
```

## ``ubos-admin createsite``

To create and deploy a new {{% gl Site %}} running one or more {{% gls App %}}:

```
% sudo ubos-admin createsite
```

and answer the questions at the terminal.

To create and deploy a new {{% gl Site %}}, running one or more {{% gls App %}} and
secured by a self-signed SSL/TLS certificate:

```
% sudo ubos-admin createsite --tls --selfsigned
```

and answer the questions at the terminal.

To create and deploy a new {{% gl Site %}}, running one or more {{% gls App %}} and
secured by a {{% gl LetsEncrypt %}} SSL/TLS certificate:

```
% sudo ubos-admin createsite --tls --letsencrypt
```

and answer the questions at the terminal.

To create and deploy a new {{% gl Site %}}, running one or more {{% gls App %}} and
secured by an official SSL/TLS certificate, make sure you have private key and
certificate files on your UBOS {{% gl Device %}}, then:

```
% sudo ubos-admin createsite --tls
```

and answer the questions at the terminal.

To only create a {{% gl Site_JSON %}} file, append a ``-n`` or ``--dry-run``
argument. To save the {{% gl Site_JSON %}} to a file, instead of emitting it on the
terminal, append ``--out <filename>`` with a suitable filename.

To create a {{% gl Site %}} from a {{% gl Site_JSON_Template %}} file:

```
% sudo ubos-admin createsite --from-template <template>
```

and UBOS will only ask for values not already provided in the template.

## ``ubos-admin deploy``

If you have a {{% gl Site_JSON %}} file for a {{% gl Site %}}, you can deploy
the {{% gl Site %}} and all {{% gls App %}} configured for this {{% gl Site %}} with:

```
% sudo ubos-admin deploy --file <site.json>
```

To obtain a {{% gl Site_JSON %}} file, either:

* export the {{% gl Site_JSON %}} file for an existing {{% gl Site %}} with
  ``ubos-admin showsite --json --site <siteid>``;

* create (but do not deploy) a {{% gl Site_JSON %}} file with
  ``ubos-admin createsite --dry-run``; or

* manually create a {{% gl Site_JSON %}} file; see the
  {{% pageref "/docs/developers/reference-linux/site-json.md" file format description %}}.

You can take an existing {{% gl Site_JSON %}} file, and edit it by, for example:

* changing the hostname;

* adding or removing {{% gls App %}} running at the {{% gl Site %}}'

* changing some of the {{% gls AppConfiguration %}}, such as the {{% gl Context_Path %}}
at which the {{% gl App %}} runs, or some of its {{% gls Customization_Point %}}.

Currently, this needs to be performed using a text editor.

Then, deploy it again with ``ubos-admin deploy --file <site.json>``. UBOS will find out
what changed, and make appropriate adjustments.

{{% warning %}}
If you remove an {{% gl App %}} from a {{% gl Site_JSON %}} file, and redeploy the
{{% gl Site_JSON %}}, the data of the removed {{% gl App %}} at this {{% gl Site %}}
will be deleted. There will be no warning. So save the data with ``ubos-admin backup``
first.
{{% /warning %}}

If you redeploy an existing {{% gl Site %}} with an existing, or new {{% gl Site_JSON %}}
file, you can create a backup of the old {{% gl Site %}} configuration and content with:

```
% sudo ubos-admin deploy --file <site.json> --backuptofile <backupfile>
```

If you additionally specify ``--template``, you can use {{% gl Site_JSON_template %}}
files, so UBOS will auto-generate identifies and unique credentials during deployment.

## ``ubos-admin hostid``

Displays a unique identifier for the {{% gl Device %}}. It is is the fingerprint of the
{{% gl Device %}}'s GPG public key. This {{% gl HostId %}} is used to identify the
{{% gl Device %}} in the ``flock`` directory on the {{% gl UBOS_Staff %}}.

{{% note %}}
This is a different key than the one used by the {{% gl Shepherd %}} to
log into the {{% gl Device %}} over the network.
{{% /note %}}

## ``ubos-admin init-staff``

Turns a USB disk device into a {{% gl UBOS_Staff %}}. This erases all existing content
on the USB disk, so do not use a {{% gl UBOS_Staff %}} USB device for any other
purpose. Invoke as:

```
% sudo ubos-admin init-staff <device>
```

## ``ubos-admin list-data-transfer-protocols``

Lists the data transfer protocols currently available for the destinations of backups.
For example, if data transfer protocol ``scp`` is listed, ``ubos-admin backup``
understands how to ``scp`` ("secure copy") the resulting backup file over the network
to another host.

Note that the list of currently available data transfer protocols may become longer if you
install certain optional packages.

## ``ubos-admin listnetconfigs``

This command shows all network configurations that UBOS could activate for the current
{{% gl Device %}}. For example, if your device has two Ethernet interfaces, your
{{% gl Device %}} could be used as a router, while this would be impossible if the
{{% gl Device %}} had only one network interface. Invoke:

```
% ubos-admin listnetconfigs
```

To set one of these netconfigs, execute ``ubos-admin setnetconfig``.

More network configurations may be available in packages not currently installed.

## ``ubos-admin listsites``

To see all {{% gls Site %}} and {{% gls App %}} currently deployed on the
{{% gl Device %}}, invoke:

```
% sudo ubos-admin listsites --detail
```

This will list hostnames, {{% gls SiteId %}}, whether or not the {{% gl Site %}} has
SSL/TLS enabled, {{% gls App %}} deployed at the various {{% gls Site %}}, their
{{% gls AppConfigId %}}, and the relative {{% gls Context_Path %}}.

For example:

```
% ubos-admin listsites --detail
Site: example.com (s20da71ce7a6da5500abd338984217cdc8a61f8de)
    Context:           /guestbook (ab274f22ba2bcab61c84e78d944f6cdd7239a999e): gladiwashere-php-mysql
    Context:           /blog (a9eef9bbf4ba932baa1b500cf520da91ca4703e26): wordpress
Site: example.net (s7ad346408fed73628fcbe01d777515fdd9b1bcd2)
    Context:           /foobar (a6e51ea98c23bc701fb10339c5991224e2c75ff3b): gladiwashere-php-mysql
```

On this {{% gl Device %}}, two {{% gls Site %}} (aka virtual hosts) are hosted. The first
{{% gl Site %}}, responding to ``example.com``, runs two {{% gls App %}}: the Glad-I-Was-Here
guestbook toy {{% gl App %}}, and Wordpress, at the URLs ``http://example.com/guestbook`` and
``http://example.com/blog``, respectively. The second {{% gl Site %}} at ``example.net``, runs
a second, independent instance of Glad-I-Was-Here at ``http://example.net/foobar``.

## ``ubos-admin read-configuration-from-staff``

Performs the same operations without rebooting that the {{% gl Device %}} would perform during
boot when a {{% gl UBOS_Staff %}} is present, such as setting up a {{% gl Shepherd %}} account.

Invoke as:

```
% sudo ubos-admin read-configuration-from-staff <device>
```

## ``ubos-admin restore``

To restore all {{% gls Site %}} and {{% gls App %}} contained in a previously created backup file
that you have on your {{% gl Device %}}, invoke:

```
% sudo ubos-admin restore --in <backupfile>
```

If your backup is available on-line at a URL instead, invoke:

```
% sudo ubos-admin restore --url <url-to-backupfile>
```

Either command will not overwrite existing {{% gls Site %}} or {{% gls App %}}; if
you wish to replace them, you need to undeploy them first with ``ubos-admin undeploy``.

To only restore a single {{% gl Site %}} (of several) contained in the same backup file,
specify the ``--siteid`` or ``--hostname`` as an argument:

```
% sudo ubos-admin restore --siteid <siteid> --in <backupfile>
```

If one or more {{% gls App %}} were upgraded since the backup was created, UBOS attempts to
transparently upgrade the data during the restore operation.

This command has many other ways of invocation; please refer to:

```
% sudo ubos-admin restore --help
```

## ``ubos-admin setnetconfig``

Sets a {{% gl Network_Configuration %}} for your {{% gl Device %}}. Some of these
{{% gls Network_Configuration %}} require the installation of additional
``ubos-networking-XXX`` packages. To determine the currently installed and available
{{% gls Network_Configuration %}}, invoke:

```
% ubos-admin listnetconfigs``.
```

To switch networking off entirely:

```
% sudo ubos-admin setnetconfig off
```

To configure all network interfaces to automatically obtain IP addresses via DHCP, if
possible:

```
% sudo ubos-admin setnetconfig client
```

To assign static IP addresses to all network interfaces:

```
% sudo ubos-admin setnetconfig standalone
```

If your {{% gl Device %}} has two Ethernet interfaces and you would like to use it as a home
gateway/router:

```
% sudo ubos-admin setnetconfig gateway
```

## ``ubos-admin setup-shepherd``

This command is particularly useful if you run UBOS in a Linux container.

```
% sudo ubos-admin setup-shepherd
```

will first ask you to enter an public ssh key, and then create the {{% gl Shepherd %}}
account, and allow ssh login with the provided public ssh key.

```
% sudo ubos-admin setup-shepherd --add-key
```

will add another public ssh key and not overwrite any public ssh key already on the
shepherd's account.

## ``ubos-admin showappconfig``

To see information about a currently deployed single {{% gl AppConfiguration %}},
invoke:

```
% sudo ubos-admin showappconfig --host <hostname> --context <path>
```

such as:

```
% sudo ubos-admin showappconfig --host example.com --context /blog
```

or use ``--appconfigid`` instead.

## ``ubos-admin shownetconfig``

To see information about the current {{% gl Network_Configuration %}}, invoke:

```
% ubos-admin shownetconfig
```

This lists all attached network interfaces, and various attributes such as whether
the interface uses DHCP, allows {{% gl App %}} access etc.

## ``ubos-admin showsite``

To see information about a currently deployed {{% gl Site %}} and its {{% gls App %}},
invoke:

```
% ubos-admin showsite --siteid <siteid>
```

or

```
% ubos-admin showsite --host <hostname>
```

For example:

```
% ubos-admin showsite --siteid s20...
example.com
    /guestbook : gladiwashere-php-mysql
    /blog : wordpress
```

This {{% gl Site %}} responds to ``example.com`` and runs two {{% gls App %}}: the
Glad-I-Was-Here guestbook, and Wordpress, at the URLs ``http://example.com/guestbook``
and ``http://example.com/blog``, respectively. Nothing is being said about other
{{% gls Site %}} that may or may not run on the same {{% gl Device %}}.

To determine information about a {{% gl Site %}}'s administrator, add the ``--adminuser``
flag to invocation. In order to see the administrator's password, the command must be
invoked with ``sudo``.

To see other credentials or otherwise not-shown customizationpoints, use ``--credentials``
and/or ``--privatecustomizationpoints``.

## ``ubos-admin start-pagekite``

To allow access from the public internet to one or more of the {{% gls Site %}}
on your {{% gl Device %}} using the {{% gl Pagekite %}} service, install package
``pagekite`` with ``sudo pacman -S pagekite`` and then execute:

```
% sudo ubos-admin start-pagekite <NNN>
```

where ``<NNN>`` is the name of your primary kite (e.g. ``johndoe.pagekite.me``). UBOS
will then ask you for the secret that goes with the kite name. You can find both of them
on the pagekite.net website after you have logged into your account there.

## ``ubos-admin status``

To print interesting information about the {{% gl Device %}}, such as available disk and
memory, invoke:

```
% sudo ubos-admin status
```

There is a variety of options to control what information will be shown.

## ``ubos-admin status-pagekite``

Shows you the status of {{% gl Pagekite %}} on your {{% gl Device %}} if you have installed
it. See ``ubos-admin start-pagekite`` above.

## ``ubos-admin stop-pagekite``

Stops {{% gl Pagekite %}} on your {{% gl Device %}} if you have installed and activated it.
See ``ubos-admin start-pagekite`` above.

## ``ubos-admin undeploy``

To undeploy an existing {{% gl Site %}} and all {{% gls App %}} running at this
{{% gl Site %}} as if they had never existed, invoke:

```
% sudo ubos-admin undeploy --siteid <siteid>
```

or:

```
% sudo ubos-admin undeploy --host <hostname>
```

{{% warning %}}
Undeploying a {{% gl Site %}} is like ``rm -rf``. All the data at the {{% gl Site %}} will be lost.
To retain the data, first run ``ubos-admin backup`` before undeploying.
{{% /warning %}}

If you want to create a backup of the {{% gl Site %}} before it is undeployed:

```
% sudo ubos-admin undeploy ... --backup <backupfile>
```

## ``ubos-admin update``

To upgrade all code on your {{% gl Device %}} to the latest version, invoke:

```
% sudo ubos-admin update
```

This may cause your {{% gl Device %}} to reboot, depending on what code is being updated.

If you would like to create a backup of all {{% gls Site %}} on the {{% gl Device %}}
as they were before the update:

```
% sudo ubos-admin update ... --backuptofile <backupfile>
```

## ``ubos-admin write-configuration-to-staff``

Saves information about the current {{% gl Device %}} to the {{% gl UBOS_Staff %}}
in directory ``flock/<HOSTID>`` where ``<HOSTID>`` is a unique {{% gl HostId %}} for
the current {{% gl Device %}} (see ``ubos-admin hostid`` above).

The saved information includes current IP address, {{% gl Device_Class %}}, SSH
server-side keys and others.
