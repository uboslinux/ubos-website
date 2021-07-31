---
title: Why do you advise against using a Raspberry Pi or other ARM device as a UBOS development machine?
weight: 40
---

The Raspberry Pi is fine to run UBOS on. But we recommend you use a PC or virtual machine
to develop for UBOS, for these two reasons:

* Development is not much fun on a slow device, and ARM-based devices like a Raspberry Pi
  are substantially slower than a modern PC.

* The Raspberry Pi and other ARM devices use an SD Card as its hard drive. SD Cards,
  unfortunately, do not lend themselves to repeated compile cycles, and have a habit of
  dying when over-used, perhaps taking your code with them.

If you must use an ARM-based device, we recommend that use use a modern Raspberry Pi
with multiple cores, and at least you store your valuable code on an external (USB) disk
instead of notoriously unreliable SD Cards. Compilations will be faster, too.

