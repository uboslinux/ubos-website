---
title: UBOS build and release process
weight: 70
---

## Channels and promotions

The following diagram shows the UBOS build and release process graphically:

![Build and release process](/images/buildrelease.png)

UBOS is a derivative of {{% gl Arch_Linux %}}. As the Arch Linux project releases
new {{% gls Package %}}, the {{% pageref "/docs/users/faq-howto-troubleshooting/why-arch.md" subset %}}
relevant to UBOS is staged in the UBOS ``dev`` channel. We do this separately for each
{{% gl Arch %}}, including ``x86_64``, ``armv6``, ``armv7`` and ``aarch64``.

Other {{% gls Package %}} that are part of UBOS but not (currently) part of Arch Linux, are also
staged in the ``dev`` channel. This includes:

* administrative {{% gls Package %}}, such as ``ubos-admin``;
* {{% gls Package %}} that UBOS distributes but Arch Linux does not, like ``pagekite``.

The UBOS team then tests the {{% gls Package %}} in the ``dev`` channel. This is the only
intended use of the ``dev`` channel; {{% gl App %}} developers and users should never directly
interact with the ``dev`` channel.

When the {{% gls Package %}} in the ``dev`` channel have passed certain tests and are considered to
be sufficiently stable, they are promoted into the UBOS ``red`` channel.

The ``red`` channel is only used by developers, not end users, and can be compared
to traditional "alpha"-quality software. {{% gl App %}} developers use the ``red``
channel to make sure their {{% gls App %}} continue to work with upcoming UBOS upgrades.

When the {{% gls Package %}} on the ``red`` channel is sufficiently stable and the
{{% gls App %}} on the ``red`` channel pass their automated tests, they are promoted to the
``yellow`` channel.

The ``yellow`` channel is similar to traditional "beta"-quality software, and is typically
used both by developers and friendly end users.

Once the ``yellow`` channel is sufficiently stable, the {{% gls Package %}} will be promoted
to the ``green``, aka production channel, where they become generally available to
all UBOS users.

## When may Packages be held back?

{{% gls Package %}} may generally be held back from promotion to the next channel
if it is known, or suspected, that either the {{% gl Package %}} is insufficiently
stable for the next channel, that the upgrade process may not be reliable
enough yet, or that other packages will break as a consequence of the upgrade.

For example, when the Apache web server became available in version 2.4,
several keywords and configuration settings changed from 2.2. Most
notably, the ``Allow from`` syntax became unavailable; if any {{% gl App %}} used
that syntax, Apache would refuse to start. While this move from Apache 2.2
to 2.4 predates the UBOS release process and thus UBOS was not affected, it is a
great example for under which circumstances packages may be held back.

Similarly, major new versions of applications are generally held at
``red`` or ``yellow`` for some time until they are promoted to ``green``.
This is the UBOS equivalent to a "beta period".
