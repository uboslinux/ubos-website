---
title: Why did you derive UBOS from Arch Linux, and what is the relationship between UBOS and Arch?
---

The first version of what became UBOS was actually based on Debian Linux. There are many
great things about debian, and things were going great, until early users complained that the
versions of the available web {{% gls App %}} were "old"; they wanted the latest and greatest.
So we tried upgrading various web {{% gls App %}} to current versions, and failed: current web
{{% gls App %}} would require current language runtimes and libraries, and Debian Stable
does not generally provide them.

In the second attempt, we worked from Ubuntu. That was better in terms of being current
with web {{% gls App %}}. But when we discovered rolling updates as provided by Arch Linux, there
was no going back: rolling upgrades are excellent for the types of systems we are
building UBOS for.

Today, UBOS is both a subset and a superset of Arch Linux:

* UBOS only includes a subset of the Arch Linux packages. For example, UBOS has picked
  Apache2 as its (current) web server and thus does not provide any other web servers.

* UBOS provides packages such as ``ubos-admin`` for one-command device
  administration, which are not available on Arch Linux. Given that Arch Linux is
  intended as a very configurable system for the power user, and ``ubos-admin`` requires
  a much tighter set of conventions, tools such as ``ubos-admin`` do not make much sense
  on Arch itself.

* UBOS provides several {{% gls Release_Channel %}} so we can support users who are
  not too technical. That would be hard to do on Arch directly.

* UBOS releases are "full-stack" tested before they are made available. Arch Linux
  only performs unit testing, and generally requires a system administrator to
  manually review and resolve possible issues. See also
  {{% pageref "/docs/developers/buildrelease.md" %}}.

In spite of this, many packages available on UBOS are identical to those on
[Arch Linux](http://archlinux.org/), and its sibling for the ARM processor architecture,
[Arch Linux](http://archlinuxarm.org/).

