---
title: "How to make an App available on UBOS: Overview"
weight: 10
---

If you have an {{% gl App %}} that you'd like to make available to UBOS users, it
is recommended you do this:

1. Say "Hi" in the [forum](/community/). We don't bite, and might even be
   helpful :-)

1. Set up a {{% pageref setting-up-development-machine %}}.

1. Package your {{% gl App %}} using ``makepkg``, with a ``PKGBUILD`` file and a
   {{% gl UBOS_Manifest %}}. You can find examples in {{% pageref toyapps %}},
   and documentation in other sections of the UBOS Documentation.

1. Test that your {{% gl App %}} plays nicely on UBOS by testing it with
   {{% pageref testing %}}.

1. Augment the list of UBOS build files
   [here](https://github.com/uboslinux/ubos-buildconfig/tree/develop/hl/us>)
   and file a pull request, so your {{% gl App %}} gets built and tested by
   the official UBOS build.

Done!
