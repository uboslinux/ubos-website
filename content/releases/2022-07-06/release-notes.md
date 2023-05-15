---
title: "Release notes: UBOS Linux apps update 2022-07-06"
date: 2022-07-06
---

## Major package upgrades in this version

Nextcloud has been upgraded to version 24, as have many of its apps.

## To upgrade

To be safe, first check the status of your {{% gl device %}}:

* ``sudo ubos-admin status``

and make sure everything is in working order. Then create a backup of all
your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

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

## Known issues

* If after the upgrade,
  ``sudo ubos-admin status``
  reports that a service called ``nextcloud@aaa.service`` has failed,
  simply restart it: ``sudo systemctl start nextcloud@aaa.service``
  (where ``aaa`` is a long hexadecimal number unique to your {{% gl device %}}.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).
