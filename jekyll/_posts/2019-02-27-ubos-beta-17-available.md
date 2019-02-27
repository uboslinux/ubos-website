---
layout: post
title:  "UBOS Beta 17 available"
date:   2019-02-27 12:00:00
author: Johannes Ernst
categories: front release beta
---

There is lots of new stuff in this update. But before we get there:

This is the last of the <a href="https://en.wikipedia.org/wiki/Mostly_Harmless">increasingly
inaccurately named</a> "beta XXX updates". UBOS has been fairly stable for some time, and
our "beta" labels are a throw-back to the past when that wasn't necessarily true. So going
forward, we will stop using the term "beta". Instead, we will focus on the distinction
between the different release channels, and at what version they are at. If you check UBOS
<a href="https://github.com/uboslinux/">on GitHub</a>, you'll see that the
milestone labels have already been renamed.

Here are some of the highlights on what is new in beta (ahem!) 17, currently available
on the ``yellow`` release channel only:

* ``ubos-admin`` is now in color! (On terminals that support it.) That makes entering
  the correct information in commands such as ``ubos-admin createsite`` visually much
  simpler. It also makes it easier to distinguish between informational messages and
  errors.

* ``ubos-admin backup`` is now the unified command for all backups in UBOS.
  Extra commands like ``ubos-admin backup-to-amazon-s3`` are gone. ``ubos-admin backup``
  can do it all, and more! It has learned not only to back up to local files, and
  to Amazon S3, but also to remote hosts with protocols such as ``ftp``, ``sftp``,
  ``scp``, ``rsync``, ``http`` and ``https``. All that's needed is to specify
  a backup destination with the protocol prefix, such as ``s3://mybucket/myfile``.

* ``ubos-admin backup`` can also encrypt backups automatically, and the key management
  for that has become much simpler.

* Upgrades have become faster, and require less storage.

* The UBOS documentation now exists in two places:

  * at <a href="/docs/">ubos.net/docs</a>, as before, you find the documentation
    for the ``green`` ("production") release channel.

  * at <a href="/docs-yellow/">ubos.net/docs-yellow</a>, which is new, you find
    the documentation for the ``yellow`` ("beta") release channel.

  As UBOS gets promoted through the release channels, new features will first
  show up on ``yellow``, and its documentation section, and later make it into
  ``green``. That clears up some confusion where sometimes the documentation seemed
  to say one thing, but the software did something else: now you can refer to the
  documentation that goes with your release channel.

* As usual, lots of other smaller improvements and fixes of bugs and annoyances.

The more detailed release notes are <a href="/docs-yellow/releases/beta17/release-notes/">here</a>.

As always, we love your <a href="/community/">feedback</a>.
