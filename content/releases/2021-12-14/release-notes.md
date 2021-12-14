---
title: "Release Notes: UBOS Linux Update 2021-12-14"
date: 2021-12-14
---

## To upgrade

{{% warning %}}
If you are on an ARM device, and you are running the Nextcloud News
app, you need to undeploy it first, otherwise the upgrade will fail.
More details below.
{{% /warning %}}

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## Major package upgrades in this version

* Mastodon
* Matomo
* Mediawiki
* Nextcloud. Many Nextcloud accessories have been upgraded as well.
* phpBB
* Webtrees
* Wordpress. Many Wordpress skins and plugins have been upgraded as well.

## Bug fixes

The usual: fixed bugs and made improvements. You can find the closed issues
[on Github](https://github.com/uboslinux/) tagged with milestone ``ubos-apps-26``.

## Known issues

* If after the upgrade, [Nextcloud](https://nextcloud.com/) reports an "internal error"
  (out-of-memory error related to the database), restart mariadb. This is easiest if you
  simply reboot your {{% gl device %}}.

* The [Nextcloud News app](https://apps.nextcloud.com/apps/news) now requires
  64bit-PHP. Lower-end (ARM) devices do not meet this requirement. Upgrading such
  a {{% gl device %}} running the Nextcloud News app will fail, as the Nextcloud
  upgrader reports an error and keeps the installation in maintenance mode. To avoid this,
  it is best to redeploy the {{% gl Site %}} without Nextcloud News before the upgrade.
  Here is a possible sequence of steps:

  1. Determine the current {{% gl Site_JSON %}} and save it to a file:

     ```
     % sudo ubos-admin showsite --json > site.json
     ```

  1. Edit that file, e.g.:

     ```
     % vi site.json
     ```

     by removing the line that reads: ``"nextcloud-news",``. Save the file.

  1. Redeploy the {{% gl Site %}}:

     ```
     % sudo ubos-admin deploy -v --file site.json
     ```

  Then upgrade your device as usual.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).



