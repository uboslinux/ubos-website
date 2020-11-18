---
title:  UBOS "yellow" update available (2019-03-29)
date:   2019-03-29 15:55:00
categories: [ front, release ]
---

This update has new packages both on the UBOS operating system level, and for applications.
Sometimes, we have to do both at the same time!

As indicated in the last update, This is also the first update in which we use a new numbering
scheme based on the date of the announcement.

For now, updates have been published to the ``yellow`` channel only. We will promote it
to ``green`` in a few days, assuming things go well. If you like to be notified when UBOS
updates have been published, or for any other notifications, here is the first news for you:

### Release notification mailing lists

* We have created notification-only mailing lists (separate for the `yellow` and the
  `green` channel) that you can subscribe to, to be notified when there are updates
  on the respective channel.
* Go [here](https://indiecomputing.hosted.phplist.com/lists/?p=subscribe&id=4) to
  subscribe.

{{% slide-in-img-right href="https://matomo.org/" src="/images/matomo-144x144.png" alt="[Matomo]" %}}

### New apps

* Matomo, a privacy-preserving alternative to cloud-based web analytics tools such
  as Google Analytics (formerly named Piwik) is now available for single-command
  installation and upgrades.

  To install, run ``ubos-admin createsite`` and specify app ``matomo``.

### Notable new packages for users:

* IPFS: go-ipfs
* More Wordpress plugins, such as Pterotype and SEO

### Key package upgrades in this release

* Nextcloud
* Mastodon
* Wordpress
* Linux is now at kernel version 5.0.x (x86_64 only for now)
* Mariadb is now at 10.3.x
* Bitcoin daemon
* Ethereum daemon

### Notable fixes and improvements:

* Various backup/restore issues were fixed. These had impacted primarily sites running
  Shaarli and Selfoss.
* Nextcloud installations now set the admin e-mail address automatically
* Nextcloud now shows memory info
* DNSSEC is turned off by default, as it appears to be incompatible with many deployed
  DNS servers that don't support it.

### Changes for developers:

* Apps based on Node now need to package their own node runtime.

### Other:

* The Personal Public License has had some clarifying edits. See
  {{% pageref "/blog/2019/03/29/license-update.md" "separate post" %}}.

### Upgrades:

* IMPORTANT: Please consult the
  {{% pageref "/releases/2019-03-29/release-notes.md" "release notes" %}} for
  platform-specific notes.

More details are in the
{{% pageref "/releases/2019-03-29/release-notes.md" "release notes" %}}.
