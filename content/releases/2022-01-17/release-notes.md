---
title: "Release Notes: UBOS Linux Update 2022-01-17"
date: 2022-01-17
---

## Major package upgrades in this version

This release brings [Nextcloud Hub II](https://nextcloud.com/hub/) to UBOS.

Nextcloud has been upgraded to version 23 (Hub II), as have many of its apps.

## To upgrade

To be safe, first check the status of your {{% gl device %}}:

* ``sudo ubos-admin status``

Then create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## Known issues

* If after the upgrade,
  ``sudo ubos-admin status``
  reports that a service called ``nextcloud@aaa.service`` has failed,
  simply restart it: ``sudo systemctl start nextcloud@aaa.service``
  (where ``aaa`` is a long hexadecimal number unique to your {{% gl device %}}.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).

