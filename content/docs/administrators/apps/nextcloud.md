---
title: Notes on Nextcloud
weight: 40
---

## On Nextcloud "apps" and UBOS Accessories

First, let's be clear about our terminology:

* In UBOS terminology, Nextcloud is an {{% gl App %}}, like Wordpress or Mediawiki
  as {{% gls App %}}.

* In UBOS terminology, anything that adds functionality to an {{% gl App %}} is called
  an {{% gl Accessory %}}.

* Nextcloud doesn't call itself an "app". Instead, it calls code that adds functionality
  to Nextcloud (like the Nextcloud calendar or address book) an "app". However, in
  UBOS terminology, that is called an {{% gl Accessory %}}.

## How to install Nextcloud "apps"

Armed with this understanding, how does one install what Nextcloud calls an "app", which
is what UBOS calls a Nextcloud {{% gl Accessory %}}? Usually, you would log into your Nextcloud
installation as administrator, navigating to the "apps" pages, and pick install new ones
from there.

This is not how it works on UBOS.

When you run Nextcloud on UBOS, you need to specify your {{% gls Accessory %}} at the time
you create your {{% gl Site %}}, or by redeploying the {{% gl Site %}} later with an updated
configuration.

Example: let's say you want to use the Nextcloud "Calendar" "app" for your {{% gl Site %}}.
When you create the {{% gl Site %}} with ``ubos-admin createsite``, you specify ``nextcloud``
as your {{% gl App %}}, and ``nextcloud-calendar`` as an {{% gl Accessory %}}. You can specify
multiple {{% gls Accessory %}} as you like.

Here's the reason why: UBOS cannot manage {{% gls App %}} that change their code base without
UBOS knowing, and that's what would be happening if Nextcloud got to add "apps" aka
{{% gl Accessory %}} by itself.

## Notes on Nextcloud "social"

UBOS makes the Nextcloud "Social" "app" available because users have requested it.
However, it is still marked as "alpha" by its developers, and in our experience, this
assessment is correct. In other words, if you decide to deploy it, do not rely on it working.

## How to install OnlyOffice and the corresponding document server

This requires two accessories:

* ``nextcloud-onlyoffice``, and
* ``nextcloud-documentserver-community``.

You may receive the message "ONLYOFFICE cannot be reached. Please contact admin". This is
because you accessed your Nextcloud through a hostname or IP address different from what
the Nextcloud installation expected.

To set the address at which the document server is available, go to the OnlyOffice
Settings in the Nextcloud user interface (as administrator, go to Settings, section Administration,
select ONLYOFFICE), and edit the Document Editing Service address. The URL there must start
with the same protocol, hostname and path as the URL you are using to access Nextcloud.

You may also need to set this the first time you access Nextcloud after initial deployment.

This is a limitation of the current Nextcloud/OnlyOffice integration.

## How to install full-text search

This requires three accessories:

* ``nextcloud-fulltextsearch``,
* ``nextcloud-files-fulltextsearch``, and
* ``nextcloud-fulltextsearch-elasticsearch``.

UBOS will automatically run all required daemons and associated commands.

## How to skip a Nextcloud version during upgrade

If you don't update your UBOS {{% gl Device %}} regularly, it may happen that you missed an
entire major Nextcloud release by the time you do finally upgrade. For example, if you deployed
your site originally with Nextcloud 18, and waited a while to upgrade, the current
version may now be Nextcloud 20. This is a problem because Nextcloud does not support
skipped upgrades.

This is issue is a known Nextcloud issue, and really needs to be solve by the Nextcloud
developers. We can only provide workarounds. The best one, of course, is the regularly update
your UBOS {{% gl Device %}}, so you do not end up in this situation. But if you do anyway,
here is a possible workaround.

First: determine whether you are indeed in this situation, by determining which version
of Nextcloud you are currently running. Execute:

```
% pacman -Qi nextcloud
```

then:

* Before you attempt to upgrade your device, create a backup of your Nextcloud installation
  with ``ubos-admin backup``.

* Undeploy Nextcloud with ``ubos-admin undeploy``. Depending how you have set up your site(s),
  it might be easiest to undeploy the entire {{% gl Site %}}, or all {{% gls Site %}},
  on your {{% gl Device %}}.
  (Make triply sure first that you have a backup for everything you will undeploy!)

* Upgrade your device with ``ubos-admin update``.

* Now restore your backup, while telling UBOS to replace package ``nextcloud`` with
  package ``nextcloud19`` (the skipped version; if you skipped more than one, do it once for
  each skipped version in sequence) during the restore. You do that with
  additional arguments: ``ubos-admin restore --migratefrom nextcloud --migrateto nextcloud19``.
  This will migrate your Nextcloud data to version 19, from which the regular upgrade
  works.

* But we also need to replace ``nextcloud19`` with the now-current ``nextcloud``, so
  we go through backup and restore one more time: ``ubos-admin backup`` and then
  ``ubos-admin restore --migratefrom nextcloud19 --migrateto nextcloud``.

* Now you should be back and running. You can clean up by removing the intermediate
  version with ``pacman -R nextcloud19``.

Sorry for the complications, but this is the best we can do if you do not regularly update
your UBOS {{% gl Device %}}.

## Nextcloud Social

If you use the Nextcloud Social app, you may see the message:

```
.well-known/webfinger isn't properly set up!
```

This is an incorrect error message, and you can ignore it. It requires a fix
upstream in Nextcloud Social (see [this issue](https://github.com/nextcloud/social/issues/816)).
