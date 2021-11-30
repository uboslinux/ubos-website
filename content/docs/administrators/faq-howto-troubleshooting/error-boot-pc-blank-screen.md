---
title: Booting UBOS on a PC starts out fine, but then the screen goes blank
---

**Q**: I am booting UBOS on a PC. The bootloader comes up and starts UBOS.
On a new screen, there are a few more boot messages, and then, the screen goes blank.
What happened?

**A**: Chances are, UBOS is booting just fine. There are just some evil forces that have
conspired to make your screen go blank, so you can't see that UBOS is booting.

The magic incantation that you need is a Linux kernel parameter. Do this:

1. Reboot.

2. When the grub bootloader screen comes up, hit the 'e' key. This will keep grub from
   continuing to boot. Instead, it will give you a window with scary-looking bootloader
   commands in it. That's where you need to apply your evil-forces-banishing
   magic incantation.

3. Move your cursor to the line which starts with ``linux`` and has lots of strange
   other words after it.

4. Move your cursor to the very end of that line, and add your magic incantation. Do not
   change any other words on that line, just add to the end.

5. Then, hit F-10 (or ctrl-X) -- see the bottom of the screen -- to continue the boot
   with your magic incantation present.

**Q**: Now just what is the magic incantation?

**A**: In many cases, it may be ``video=LVDS-1:d``. As magic goes, your mileage may vary
depending on your computer hardware and configuration. More options can be found
[at ibiblio.org](http://distro.ibiblio.org/fatdog/web/faqs/boot-options.html).

**Q**: The magic incantation worked, but do I need to that every time?

**A**: No. When you have booted your PC from a UBOS boot stick, and you install UBOS on a
hard drive permanently on this PC, add an extra argument to the ``ubos-install``
command that holds your magic incantation. For example, if you install UBOS on your
first hard drive, say:

```
% sudo ubos-install /dev/sda --addkernelparameter video=LVDS-1:d
```

This will put the incantation into the grub setting permanently.

**Q**: If I forgot to add that kernel parameter during installation, do I need to reinstall?

**A**: No. Open ``/etc/default/grub`` with a text editor of your choice, and look for the
line that starts with ``GRUB_CMDLINE_LINUX_DEFAULT``. Append the parameter you wanted, and save
the file. For example, you may want this line to read:

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet video=LVDS-1:d"
```

Then, update your boot loader by invoking:

```
# grub-install --recheck /dev/sda
```

Of course, specify a device name other than ``/dev/sda`` if you boot from a different hard drive.
