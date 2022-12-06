---
title: "Release notes: UBOS Mesh update red 2022-12-06 (0.10)"
date: 2022-12-06
---

## Note

This is for developers on the `red` {{% gl release_channel %}} only.

## Major changes in this version

* {{% gl MeshBase %}} indexing is now performed by two separate {{% gls bot %}}, and the
  index is now stored natively as {{% gls MeshObject %}} in the same {{% gl MeshBase %}}.
  Previously, the full-text search index and the type index were implemented as bespoke
  code with storage outside of their {{% gl MeshBase %}}. This change simplifies and
  unifies application development, and opens up powerful opportunities, e.g.

  * each {{% gl MeshBase %}} now has its own index;
  * each {{% gl MeshBase %}} can now set its own indexing policy in principle, from no
    indexing at  all, to indexing only words, or only types, or in some language vs
    another, or custom indexing.

* Some operations have been sped up by reducing the need, when iterating over data,
  to go back to the on-disk storage system (current Mariadb).

* Some UI improvements, including reporting some basic statistics.

## Availability

In the repos on `x86_64` and `aarch64`.

## Known issues

This is pre-release software not ready yet for production. There are
potentially many issues, many of which may be unknown at this time.
Use at your own risk.

This does not affect the stability and security of {{% gl linux %}} and
standalone {{% gls app %}} like Nextcloud.
