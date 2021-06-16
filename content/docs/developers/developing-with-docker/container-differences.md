---
title: Differences between the ubos-target container and a typical UBOS production system
---

The `ubos-target` container in the Docker development setup is
very similar to a typical UBOS production system, on either virtualized
or physical hardware.

Some of the differences are:

* UBOS production systems take advantage of the btrfs filesystem, such as
  to create file system snapshots during system administration operations with
  `ubos-admin`. Docker provides its own filesystem, and so these features are
  not available.

  However, as an {{% gl app %}} or {{% gl accessory %}} developer,
  this should not impact you at all.

* The `ubos-target` container allows you to install {{% gls package %}}
  that are not digitally signed. This is not permitted on production systems.
  This difference makes it easier for you, as developer, to quickly deploy
  work-in-progress packages without having to set up an additional package
  signing infrastructure.
