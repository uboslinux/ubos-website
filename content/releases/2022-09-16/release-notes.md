---
title: "Release notes: UBOS Mesh Update on red and yellow 2022-09-16"
date: 2022-09-16
---

## Note to standalone app users

If you are a UBOS user who runs {{% gl linux %}} with standalone
{{% gls app %}} like Nextcloud, this update does not affect you.

## Major changes in this version

* The Amazon Importer has been updated to Amazon's August 2022 export
  format. It now imports all data -- some of it semantically, and the
  rest of it structurally (untyped).

* The full-text search now also indexes (untyped) {{% gl Attribute %}} values.
  Together, this means that if an import contains a String, it can be
  searched.

* The Importer framework has gotten major new functionality that enables
  modular importer development: only write new importer code for those portions
  of an import that are actually new or different compared to an older
  version of the importer.

* The AccountBar UI widget has been added that provides a login dialog
  and related functionality.

* The AccessManager has been reviewed, and improved. Some potential
  security issues were fixed.

* The PeerTalk handler now requires a bearer access token.

* The history of a MeshBase now has a write API. Things that happened in the
  past -- but that we didn't know of at the time -- can now be added
  into the history of the MeshBase at that historical time. There is more
  work to be done to integrate this with importers, although the Facebook
  importer has been partially migrated (and is therefore currently less
  functional than it was. Work in progress.)

* New additions:

  * A new skin
  * Viewlets for Accounts, data imported from the untyped importer,
    and for a (so far empty) landing page.

* Obviously, lots of other bug fixes and improvements.

* UBOS Mesh now consists of 70 packages.

## Availability

Pre-built packages are available in the `red` and `yellow`
{{% gls release_channel %}}. As this is pre-release software, they
are not available in the `green` channel yet.

You may need to add the `mesh` repository to your `pacman` configuration,
e.g. by creating file `cat /etc/pacman.d/repositories.d/mesh` with
content:

```
[mesh]
Server = http://depot.ubosfiles.net/$channel/$arch/mesh
```

Source code and bug tracker can be found at
[gitlab.com/ubos](https://gitlab.com/ubos).

## Known issues

This is pre-release software not ready yet for production. There are
potentially many issues, many of which may be unknown at this time.
Use at your own risk.

This does not affect the stability and security of {{% gl linux %}} and
standalone {{% gls app %}} like Nextcloud.
