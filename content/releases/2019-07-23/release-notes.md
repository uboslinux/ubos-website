---
title: "Release notes: apps update 2019-07-23"
date: 2019-07-23
---

## To upgrade

To be safe, first create a backup of all your sites to a suitable file, with a
command such as:

* ``sudo ubos-admin backup --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## What's new

### New functionality:

* If you have not upgraded your UBOS device running Nextcloud for a while, the Nextcloud
  upgrader may not be able to upgrade your installation in one go. As a workaround, we have
  introduced package ``nextcloud15``, which contains Nextcloud version 15. You can use this
  package as an intermediate step to upgrade from an earlier Nextcloud to the current version.
  This is described in more detail in {{% pageref "/docs/administrators/apps/nextcloud.md" %}}.

* If you redeploy your Site running Nextcloud with a different administrator password
  than originally, the Nextcloud installation will be updated with the new admin password.
  This makes for an effective admin password reset.

### Package upgrades:

* Mediawiki has been upgraded to 1.33.0

* Nextcloud has been upgraded to 16.0.3. Also, the following accessories were upgraded or
  newly added:

  * ``nextcloud-audioplayer``
  * ``nextcloud-auto-mail-accounts``
  * ``nextcloud-bookmarks``
  * ``nextcloud-bruteforcesettings``
  * ``nextcloud-contacts``
  * ``nextcloud-deck``
  * ``nextcloud-groupfolders``
  * ``nextcloud-mail``
  * ``nextcloud-notes``
  * ``nextcloud-onlyoffice``
  * ``nextcloud-passwords``
  * ``nextcloud-social``
  * ``nextcloud-spreed``
  * ``nextcloud-tasks``
  * ``nextcloud-twofactor-totp``

* Wordpress has been upgraded to 5.2.2. Also, the following accessories were upgraded or
  newly added:

  * ``wordpress-plugin-google-analytics-for-wordpress``
  * ``wordpress-plugin-indieauth``
  * ``wordpress-plugin-indieweb-post-kinds``
  * ``wordpress-plugin-micropub``
  * ``wordpress-plugin-semantic-linkbacks``
  * ``wordpress-plugin-seo``
  * ``wordpress-plugin-social-networks-auto-poster-facebook-twitter-g``
  * ``wordpress-plugin-syndication-links``
  * ``wordpress-plugin-webmention``
  * ``wordpress-plugin-wp-mail-smtp``
  * ``wordpress-theme-responsive``
  * ``wordpress-theme-twentyfifteen``
  * ``wordpress-theme-twentyfourteen``
  * ``wordpress-theme-twentythirteen``
  * ``wordpress-theme-twentytwelve``

### Bug fixes

The usual: fixed bugs and made improvements. You can find the closed issues
[on Github](https://github.com/uboslinux/) tagged with milestone ``ubos-apps-19``.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).
