---
title:  "UBOS Beta 11 released with support for Marvell ESPRESSObin"
date:   2017-06-11 23:00:00
categories: [ front, release, beta ]
---

{{% slide-in-img-right href="http://espressobin.net/" src="/images/espressobin-350x43.png" %}}

UBOS Beta 11 is here, and we are proud to add the
[**Marvell ESPRESSObin**](http://espressobin.net/) to the list of supported devices.

Launched [on Kickstarter](https://www.kickstarter.com/projects/874883570/marvell-espressobin-board)
earlier this year, the ESPRESSObin is an interesting board: it doesn't have any graphics (which is
fine with us because most UBOS devices are used as headless servers) but instead it has three
Ethernet ports and a SATA connector. The currently available 1GB version costs
only [$49 on Amazon](https://www.amazon.com/Globalscale-Technologies-Inc-SBUD102-ESPRESSObin/dp/B06Y3V2FBK/ref=sr_1_1). So it's
perfect for running UBOS.

{{% slide-in-img-right href="https://www.raspberrypi.org/products/pi-zero-w/" src="/images/rpi-zero-w.png" %}}

We have also verified that the **Raspberry Pi Zero W** (the $10 version that has WiFi)
also works out of the box with UBOS.

As usual, there have also been many upgrades, bug fixes and new functionality has been
added. Here are the highlights:

 * The ``smartctld`` daemon is now running by default. You can use this to get e-mails when your disk
   is about to fail.

 * Nextcloud has been upgraded to current version 12, and we have added a number of
   frequently-used Nextcloud "apps": calendar, contacts, mail, news, notes, spreed and tasks.
   Not only can you now bring your calendar and contact info home, you can also start video
   conferences right from your UBOS home server.

 * UBOS can now run Python/Django apps, just as easily as other types of apps.

 * Hundreds of other package upgrades.

and more! More details are in the release notes ~~here~~.

This time, upgrading a device that is running a previous UBOS version is a teensy bit more complicated.
Due to some changes in Arch Linux (our upstream distro), the command ``sudo ubos-admin update`` may fail on
the first try. To proceed, execute ``sudo rm /etc/ssl/certs/ca-certificates.crt`` to delete
that file, and then say ``sudo ubos-admin update`` again. The upgrade should work then.

We'd love your {{% pageref "/community.md" feedback %}}.

