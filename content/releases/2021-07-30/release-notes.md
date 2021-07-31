---
title: "Release Notes: UBOS Linux Update 2021-07-30"
date: 2021-07-30
---

## To upgrade

To be safe, first create a backup of all your sites, with a command such as:

* ``sudo ubos-admin backup --all --backuptodirectory ~``

Then, update your device:

* ``sudo ubos-admin update -v``

## New: revamped developer experience

To make packaging apps for UBOS simpler, we now provide a pair of Docker
containers, and a [tutorial](/docs/developers/tutorials/) for how to use them:

* One container is used for building packages, and has the most common
  build tools pre-installed, so developers can build immediately with almost
  no required setup.

* The other container simulates a typical target UBOS system, to test
  the built packages in a real-world environment.

This allows developers to use any platform they love as their development
platform for UBOS (as long as it runs Docker), their favorite editor and
other tools on that platform, and speeds up setup very considerably.

For developers who prefer `systemd-nspawn` over Docker on Linux, a second
[tutorial](/docs/developers/tutorials/) describes a very similar setup.

## Other new features and key changes

* The [developer documentation](/docs/developers/) on the UBOS website has been reorganized.

* UBOS now is easier to use inside of a Docker container; for example,
  UBOS has gained a Docker-specific network configuration so Docker and
  UBOS network management don't get into each other's way.

* Some IPv6 traffic that had been incorrectly blocked by the UBOS firewall
  is not blocked any more.

* UBOS can now use LLMNR to acquire an IPv6 address.

* High load is not considered an error any more in `ubos-admin status`; only
  if the high load persists for a longer period of time.

* `ubos-admin setup-shepherd` had its arguments and behavior made simpler
  and more consistent.

* `ubos-install` can run an extra script on the installed system, at the end of
  the installation before the installed system is unmounted.

* The UBOS build tool `macrobuild` now defines its tasks in more sane manner.

* PHP is now at version 8.

* All "master" branches in Git have been renamed to "main".

## Package upgrades in this version

* Almost 700 packages in have been updated, including apps phpBB and Wordpress.

## Bug fixes

The usual: fixed bugs and made improvements. You can find the closed issues
[on Github](https://github.com/uboslinux/) tagged with milestone ``ubos-25``.

## Need help?

Post to the [UBOS forum](https://forum.ubos.net/).

