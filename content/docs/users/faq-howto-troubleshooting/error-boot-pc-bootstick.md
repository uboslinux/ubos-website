---
title: Cannot boot UBOS from boot stick on a PC
---

If you created a boot stick for x86_64 per then instructions in
{{% pageref "installation/x86_bootstick.md" %}} but the PC still boots from the
previously installed operating system, not UBOS, chances are that a setting in
your BIOS needs to be changed. To do that:

1. Reboot your PC.

1. Immediately after reboot, the PC's BIOS runs. It usually tells you about a key to
   press to enter "settings" or "BIOS" or such. This key often is the delete key, or
   a function key. Press that key immediately. It tends to pass by quickly, so you
   may have to reboot again to catch it.

1. Once you have entered the BIOS, you need to look for the setting. All BIOS's are
   different, and sometimes this particular setting is really hard to find.

1. When you have found the setting and set it to allow booting from a USB disk, save
   the settings and reboot. The BIOS screen usually tells you how to save and restart.

1. Make sure the UBOS boot stick had been inserted already at the time you reboot.

1. Then, you still might need to find yet another key to press quickly that gives you
   a popup dialog in which you can select which device to boot from.

1. Select the device that seems to be your USB stick. It won't be SATA (that's a built-in
   disk) but BIOS manufacturers seem to like to be cryptic names, so you might have
   to try out a few alternatives among what it is listed.
