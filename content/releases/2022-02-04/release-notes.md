---
title: "Release notes: UBOS Linux update 2022-02-04"
date: 2022-02-04
---

## Notable changes

This is a minor bug fix release. The following issues were fixed:

* Failed to restore from backup under some circumstances if the backup contains
  a symbolic link. ([Link](https://github.com/uboslinux/ubos-admin/issues/855))

* Failed to restore from backup under some circumstances if the backup contains
  certain JSON files. ([Link](https://github.com/uboslinux/ubos-admin/issues/854))

* SMTP setup when running Nextcloud 22. ([Link](https://github.com/uboslinux/ubos-app-nextcloud/issues/113))

## To upgrade

To be safe, first check the status of your {{% gl device %}}:

* ``sudo ubos-admin status``

Then create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).

