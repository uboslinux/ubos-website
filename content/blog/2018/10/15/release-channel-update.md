---
title:  "Release channel update"
date:   2018-10-15 21:00:00
categories: [ front, news ]
---

{{% slide-in-img-right href="https://indiecomputing.com/products/ubosbox-nextcloud-on-nuc/"         src="/images/2018-08-23/ubosbox-nextcloud-on-nuc-model-a-on-200x150.jpg" %}}
{{% slide-in-img-right href="https://indiecomputing.com/products/ubosbox-nextcloud-on-raspberrypi/" src="/images/2018-08-23/ubosbox-nextcloud-on-raspberrypi-on-200x150.jpg" style="clear: both" %}}

The first commercial products based on UBOS,
[UBOSbox Nextcloud](https://indiecomputing.com/products/), are shipping,
and they ship on the all-new "green" release channel, which is now generally available.

What does that mean?

Well, as described in more detail {{% pageref "/docs/developers/buildrelease.md" "in the documentation" %}},
UBOS is developed and released in several "release channels":

* The gory, technical operating-system level work is performed in the "dev"
  release channel. Nobody except for OS developers should ever have to use it.

* Once "dev" works well enough for application developers, it gets promoted to
  the "red" release channel. That's where much UBOS testing occurs, and that's where
  apps are developed/packaged for UBOS.

* Once that is good enough, OS and/or apps get promoted to the "yellow" release
  channel. That has been the default release channel for images downloaded from
  this website, and we are planning to keep it that way. Operating system and apps
  on the "yellow" release channel are intended to be good enough to run on an
  ongoing basis, although occasionally hiccups may occur.

* The all-new "green" release channel is even more mature than the "yellow" one,
  and only contains a subset of the functionality: that subset that is commercially
  supported in products such as
  [UBOSbox Nextcloud](https://indiecomputing.com/products/).

The {{% pageref "/apps.md" "apps page" %}} has been updated to reflect the different
levels of availability.
