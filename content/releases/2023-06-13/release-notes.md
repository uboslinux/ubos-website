---
title: "Release notes: UBOS Linux OS and apps update 2023-06-13"
date: 2023-06-13
---

## Release overview

This update contains hundreds of updated and new packages, both on an operating system
level and applications. There are a few bug fixes, but mostly this update consists of
updated packages.

Both the "yellow" and the "green" release channel have been updated.

Notable app upgrades:

* Nextcloud is now at version 26.
* Mediawiki is now at version 1.39.3.
* Decko is now at version 0.15.6.

## To upgrade

{{% warning %}}
If you are running UBOS on an Amazon Web Services EC2 "t2" instance, do not run this upgrade.
The now fairly old t2 instances do not support the newer Linux kernel we are using, and will
fail to reboot. Instead, migrate your sites to a newer instance type (e.g. "t3"), such as
by creating a backup of your sites to Amazon S3 with `ubos-admin backup`, and then restoring
them to the new instance with `ubos-admin restore`.
{{% /warning %}}

To be safe, first check the status of your {{% gl device %}}:

* ``sudo ubos-admin status``

and make sure everything is in working order. Then create a backup of all
your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

As as so many packages are new, the upgrade can take a while.

{{% note %}}
This upgrade can take a long time (hours), because some cryptographic keys
need to be updated, and the key server we depend on can be very slow. If
you don't like this, first update your keys:

* {{% pageref "/docs/administrators/faq-howto-troubleshooting/howto-root.md" "log on as root" %}},
  and run ``pacman-key --refresh-keys``, and then
* run ``ubos-admin update --nokeyrefresh``

This will take about the same amount of time, but your {{% gls site %}}
will continue to be working while ``pacman-key`` is running. The actual
update then can be much faster.
{{% / note %}}

## Need help?

Find us in the Fediverse at [@ubos@mastodon.social](https://mastodon.social/@ubos)
with an app such as [Mastodon](https://joinmastodon.org/).
