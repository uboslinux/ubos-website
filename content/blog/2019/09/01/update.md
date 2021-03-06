---
title:  UBOS update available on all release channels (2019-09-01)
date:   2019-09-01 21:55:00
categories: [ front, release ]
---

Lots of new functionality in this UBOS update, which is now available on all release
channels and on all platforms.

As usual, the details are in the
{{% pageref "/releases/2019-09-01/release-notes.md" "release notes" %}}, so here are
the highlights:

### More and improved administration tools

* Every wondered whether your UBOS device is working as it should, or whether you are
  overlooking something? ``ubos-admin status`` has lots of new functionality to help you
  out.

  For example ``ubos-admin status --problems`` will tell you which problems UBOS
  is aware of, such as a daemon that failed, or a disk that is getting too full. And it
  keeps its answer short and sweet if everything seems fine. (You are get the full details
  with various other command-line options; see documentation.)

  This makes ongoing systems administration much simpler for professionals and novices
  alike.

* Extensions to ``ubos-admin showsite`` make some common tasks much simpler, such as
  determining what the Site administrator account is. While we were at it, we also
  removed from clutter from the output that isn't usually needed.

* ``ubos-admin createsite`` can now use a template Site JSON, and will only ask you for
  values not already provided. This has some intriguing possibilities for shipping
  templates for complex Sites with multiple Apps. We'll have more to say about that in
  the future.

### Speed improvements

* Backups have become faster, as UBOS now applies a heuristic on which files to compress
  and which not.

* Also, UBOS now lets you invoke certain ``ubos-admin`` subcommands concurrently with
  each other, which makes it easier to, say, look at the configuration on a site already
  running on your device, while creating another.

### LetsEncrypt integration rewrite

Our LetsEncrypt integration wasn't as flexible (and had more issues) than we wanted,
so we basically did a rewrite. Here are some tricks UBOS as learned:

* Backing up a LetsEncrypt-protected Site and restoring it to a different hostname,
  or on a different device is now supported. UBOS will transparently get new certificates
  if it needs to.

* UBOS will smartly reuse LetsEncrypt certificates it has already and avoid getting new
  ones if possible.

* When we tested a LetsEncrypt-protected site running this new version of UBOS with the
  tools provided by [SSL Labs](https://www.ssllabs.com/>), we obtained an "A" rating.
  Your LetsEncrypt-protected sites running on UBOS should, too, after this upgrade.

### Lots of little usability improvements

* ``ubos-install`` will refuse to install to a mounted disk.

* The UBOS Staff now lists the devices first that were most recently updated.

* Logging in via ``ssh`` now presents the UBOS banner.

* The VirtualBox image is now larger.

* Improved progress messages.

* Various documentation improvements and bug fixes.

### New and improved functionality for developers:

* Apps can now require TLS by saying so in the UBOS Manifest. This makes it impossible
  to deploy the App to a Site not protected by (official, or self-signed) TLS.

* A defined conflict resolution strategy has been implemented for when two apps deployed
  to the same Site request the same entries in the Site's ``.well-known`` directory;
  depending on the entry, one takes preference over another, or the entries are merged.

### Need help?

Post to the [UBOS forum](https://forum.ubos.net/).

More details are in the
{{% pageref "/releases/2019-09-01/release-notes.md" "release notes" %}}.

