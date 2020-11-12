---
title: Why do you recommend to use Arch Linux as the development host system instead of UBOS itself?
---

For development, developers usually want to use more {{% gls Package %}} than are contained
in UBOS, e.g. graphical desktop environments, editors, debuggers, test scripts and so forth.
These are out of scope for UBOS. Most of them are available on Arch Linux, however.

As UBOS is an Arch Linux derivative, this keeps development system and run-time system
close. If you develop in Arch, and run your UBOS {{% gl App %}} in a UBOS container, you get
the best of both worlds.

If you build and test in UBOS containers, however, it appears most systemd-based
distros would work just fine as development hosts.
