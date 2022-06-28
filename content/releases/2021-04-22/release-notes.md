---
title: "Release notes: UBOS Linux and apps update 2021-04-22"
date: 2021-04-22
---

## To upgrade

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## New features and key changes

* `ubos-admin status` has learned a number of new tricks. It can now report on
  IP addresses, incompletely performed upgrades, and more. It also
  distinguishes between "soft" and "hard" scenarios for disks getting full.

* `ubos-admin createsite` is more tolerant and explains better when certain
  incompatible input is provided, such as adding the wrong {{% gl accessory %}}
  to an {{% gl app %}}, or attempting to run an {{% gl app %}} at a
  {{% gl wildcard_hostname %}}.

* If the {{% gl ubos_staff %}} is written during boot of a {{% gl device %}}
  while no network is available, the generated HTML now displays the warning message
  much more prominently. This was done in direct response to user feedback as
  previously it could easily be overlooked.

* All MySQL databases are now provisioned, by default, as ``utf8mb4``, a more complete
  UTF-8 character set implementation than the previous default.


## Major package upgrades in this version

* Mastodon
* Matomo
* Mattermost
* Nextcloud. Many Nextcloud accessories have been upgraded as well.
* Webtrees
* Wordpress. Many Wordpress skins and plugins have been upgraded as well.

## Bug fixes

The usual: fixed bugs and made improvements. You can find the closed issues
[on Github](https://github.com/uboslinux/) tagged with milestone ``ubos-24``.

## Known issues

Mastodon may produce an error when posting for the first time. A
``sudo ubos-admin update`` seems to make it go away.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).

