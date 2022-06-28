---
title: "Release notes: apps update 2021-01-12"
date: 2021-01-12
---

## To upgrade

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## Major package upgrades in this version

* Matomo is now at version 4.1.0

* Mattermost is now at version 5.30.1

* Nextcloud is now at version 20.0.4. Many Nextcloud accessories have been
  upgraded as well.

* phpBB is now at version 3.3.2

* Shaarli is now at version 0.12.1

* Webtrees is now at version 2.0.11

## Bug fixes

The usual: fixed bugs and made improvements. You can find the closed issues
[on Github](https://github.com/uboslinux/) tagged with milestone ``ubos-apps-25``.

## Known issues

Mastodon may produce an error when posting for the first time. A
``sudo ubos-admin update`` seems to make it go away.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).
