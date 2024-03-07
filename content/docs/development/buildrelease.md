---
title: Release channels and UBOS release process
weight: 40
---

## Channels and promotions

The following diagram shows the UBOS build and release process graphically:

![Build and release process](/images/buildrelease.png)

{{% gl linux %}} is a derivative of {{% gl Arch_Linux %}}:

* Most packages on {{% gl linux %}} are identical to those on {{% gl Arch_Linux %}}.

* We recompile some packages, such as ``mariadb``, in order to enable {{% gls Device %}}
  to store large data files on a ``/ubos`` partition, rather than ``/var``. This makes
  the management of {{% gls personal_server %}} simpler.

* Some other packages are unique to {{% gl linux %}}, such as the packages that form
  {{% gl gears %}} and {{% gl mesh %}}.

As the Arch Linux project releases
new {{% gls Package %}}, the {{% pageref "/docs/operation/faq-howto-troubleshooting/why-arch.md" subset %}}
relevant to UBOS is staged in the UBOS ``dev`` channel. We do this separately for each
{{% gl Arch %}}, including ``x86_64`` and ``aarch64``.

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
