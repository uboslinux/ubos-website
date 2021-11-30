---
title:  "UBOS Beta 3 is out: added Raspberry Pi 2, Beagle Bone Black, and the UBOS Staff"
date:   2015-03-13 09:00:00
categories: [ front, release, beta ]
---

We are proud that UBOS beta 3 has been released this morning.

{{% slide-in-img-right src="/images/pc-79x100.png"      alt="[PC]" %}}
{{% slide-in-img-right src="/images/vbox-82x100.png"    alt="[Virtual Box]" %}}
{{% slide-in-img-right src="/images/rpi-83x100.png"     alt="[Raspberry Pi]" %}}
{{% slide-in-img-right src="/images/beagle-100x100.png" alt="[Beagle Bone Black]" %}}

There are two major new features:

1. UBOS now also supports the quad-core
   Raspberry Pi 2, and the Beagle Bone Black. These two new platforms join the original Raspberry Pi and
   the x86 (64bit) platform for physical and virtualized computers, for more options to run UBOS.

2. The UBOS Staff makes secure configuration of UBOS devices without keyboard and monitor a snap.
   See [blog post](http://upon2020.com/blog/2015/03/ubos-shepherd-rules-their-iot-device-flock-with-a-staff/)
   and {{% pageref "/docs/administrators/shepherd-staff.md" documentation %}}.

For more details, refer to the ~~release notes~~.

### How to upgrade

If you are an existing UBOS user and want to upgrade, log into your UBOS device.
First, you might want to make a backup of your sites:

```
% sudo ubos-admin backup --out ~/backup-$(date +%Y%m%d%H%M).ubos-backup
```

Then, to upgrade UBOS and all apps on your device, all you need to do is:

```
% sudo ubos-admin update
```

### For new users

{{% pageref "/quickstart.md" %}}
